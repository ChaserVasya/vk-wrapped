import { StatusProcessorService } from '../services/status-processor';
import { AudioStatus, VKStatus } from '../types';

// Мок для DatabaseService
const mockDatabaseService = {
    getActiveSession: jest.fn(),
    createActiveSession: jest.fn(),
    updateActiveSession: jest.fn(),
    finishAllActiveSessions: jest.fn(),
    getAllCurrentSessions: jest.fn(),
    getCompletedSessions: jest.fn(),
    close: jest.fn(),
} as any;

describe('Session Tracking Logic', () => {
    let statusProcessor: StatusProcessorService;

    beforeEach(() => {
        jest.clearAllMocks();
        statusProcessor = new StatusProcessorService(mockDatabaseService);
    });

    describe('Различные сценарии прослушивания', () => {
        const track1: AudioStatus = {
            id: 456242928,
            owner_id: 383475766,
            artist: 'Artist 1',
            title: 'Track 1'
        };

        const track2: AudioStatus = {
            id: 456242929,
            owner_id: 383475766,
            artist: 'Artist 2',
            title: 'Track 2'
        };

        const track3: AudioStatus = {
            id: 456242930,
            owner_id: 383475766,
            artist: 'Artist 3',
            title: 'Track 3'
        };

        it('Сценарий 1: Трек 1 → Трек 2 → Трек 1 (3 отдельные сессии)', async () => {
            // Трек 1 - первое прослушивание
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Трек 2 - новое прослушивание
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track1.owner_id}_${track1.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 1
            await statusProcessor.processStatus({ status_audio: track2 });

            // Трек 1 - возврат к первому треку (новая сессия)
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track2.owner_id}_${track2.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 2
            await statusProcessor.processStatus({ status_audio: track1 });

            // Останавливаем музыку
            await statusProcessor.processStatus({});

            // Проверяем что createActiveSession вызывался 3 раза
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(3);
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();

            // Проверяем что finishAllActiveSessions вызывался при каждой смене трека (2 раза) + при остановке (1 раз)
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(3);
        });

        it('Сценарий 2: Трек 1 → Трек 1 → Трек 1 (1 сессия с обновлениями)', async () => {
            // Первое прослушивание трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Продолжение прослушивания трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue({
                full_id: `${track1.owner_id}_${track1.id}`,
                first_observed: new Date(),
                last_seen: new Date()
            });
            await statusProcessor.processStatus({ status_audio: track1 });

            // Еще продолжение прослушивания трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue({
                full_id: `${track1.owner_id}_${track1.id}`,
                first_observed: new Date(),
                last_seen: new Date()
            });
            await statusProcessor.processStatus({ status_audio: track1 });

            // Останавливаем музыку
            await statusProcessor.processStatus({});

            // Проверяем что createActiveSession вызывался 1 раз (только первое прослушивание)
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(1);
            // Проверяем что updateActiveSession вызывался 2 раза (продолжение прослушивания)
            expect(mockDatabaseService.updateActiveSession).toHaveBeenCalledTimes(2);
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
        });

        it('Сценарий 3: Трек 1 → Пауза → Трек 1 (2 отдельные сессии)', async () => {
            // Первое прослушивание трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Пауза (нет музыки)
            await statusProcessor.processStatus({});

            // Возврат к треку 1 (новая сессия)
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Проверяем что createActiveSession вызывался 2 раза
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(2);
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
        });

        it('Сценарий 4: Трек 1 → Трек 2 → Трек 3 → Трек 1 (4 отдельные сессии)', async () => {
            // Трек 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Трек 2
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track1.owner_id}_${track1.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 1
            await statusProcessor.processStatus({ status_audio: track2 });

            // Трек 3
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track2.owner_id}_${track2.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 2
            await statusProcessor.processStatus({ status_audio: track3 });

            // Возврат к треку 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track3.owner_id}_${track3.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 3
            await statusProcessor.processStatus({ status_audio: track1 });

            // Останавливаем музыку
            await statusProcessor.processStatus({});

            // Проверяем что createActiveSession вызывался 4 раза
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(4);
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
            // Проверяем что finishAllActiveSessions вызывался при каждой смене трека (3 раза) + при остановке (1 раз)
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(4);
        });

        it('Сценарий 5: Трек 1 → Трек 1 (продолжение) → Трек 2 → Трек 1 (3 сессии)', async () => {
            // Первое прослушивание трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Продолжение прослушивания трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue({
                full_id: `${track1.owner_id}_${track1.id}`,
                first_observed: new Date(),
                last_seen: new Date()
            });
            await statusProcessor.processStatus({ status_audio: track1 });

            // Переключение на трек 2
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track1.owner_id}_${track1.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 1
            await statusProcessor.processStatus({ status_audio: track2 });

            // Возврат к треку 1 (новая сессия)
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track2.owner_id}_${track2.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 2
            await statusProcessor.processStatus({ status_audio: track1 });

            // Останавливаем музыку
            await statusProcessor.processStatus({});

            // Проверяем что createActiveSession вызывался 3 раза
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(3);
            // Проверяем что updateActiveSession вызывался 1 раз
            expect(mockDatabaseService.updateActiveSession).toHaveBeenCalledTimes(1);
            // Проверяем что finishAllActiveSessions вызывался при каждой смене трека (2 раза) + при остановке (1 раз)
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(3);
        });

        it('Сценарий 6: Пауза → Трек 1 → Пауза → Трек 1 (2 отдельные сессии)', async () => {
            // Начинаем с паузы
            await statusProcessor.processStatus({});

            // Первое прослушивание трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Пауза
            await statusProcessor.processStatus({});

            // Возврат к треку 1 (новая сессия)
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Проверяем что createActiveSession вызывался 2 раза
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(2);
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(2);
        });

        it('Сценарий 7: Трек 1 → Трек 1 → Трек 2 → Трек 2 → Трек 1 (3 сессии)', async () => {
            // Первое прослушивание трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий
            await statusProcessor.processStatus({ status_audio: track1 });

            // Продолжение прослушивания трека 1
            mockDatabaseService.getActiveSession.mockResolvedValue({
                full_id: `${track1.owner_id}_${track1.id}`,
                first_observed: new Date(),
                last_seen: new Date()
            });
            await statusProcessor.processStatus({ status_audio: track1 });

            // Переключение на трек 2
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track1.owner_id}_${track1.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 1
            await statusProcessor.processStatus({ status_audio: track2 });

            // Продолжение прослушивания трека 2
            mockDatabaseService.getActiveSession.mockResolvedValue({
                full_id: `${track2.owner_id}_${track2.id}`,
                first_observed: new Date(),
                last_seen: new Date()
            });
            await statusProcessor.processStatus({ status_audio: track2 });

            // Возврат к треку 1 (новая сессия)
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([
                { full_id: `${track2.owner_id}_${track2.id}`, first_observed: new Date(), last_seen: new Date() }
            ]); // Есть активная сессия для трека 2
            await statusProcessor.processStatus({ status_audio: track1 });

            // Останавливаем музыку
            await statusProcessor.processStatus({});

            // Проверяем что createActiveSession вызывался 3 раза
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(3);
            // Проверяем что updateActiveSession вызывался 2 раза
            expect(mockDatabaseService.updateActiveSession).toHaveBeenCalledTimes(2);
            // Проверяем что finishAllActiveSessions вызывался при каждой смене трека (2 раза) + при остановке (1 раз)
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(3);
        });
    });

    describe('Обработка невалидных сессий', () => {
        const track1: AudioStatus = {
            id: 456242928,
            owner_id: 383475766,
            artist: 'Artist 1',
            title: 'Track 1'
        };

        it('Создает новую сессию если активная сессия невалидна', async () => {
            // Возвращаем невалидную сессию (с невалидными датами)
            mockDatabaseService.getActiveSession.mockResolvedValue({
                full_id: `${track1.owner_id}_${track1.id}`,
                first_observed: new Date('invalid-date'),
                last_seen: new Date('invalid-date')
            });
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

            await statusProcessor.processStatus({ status_audio: track1 });

            // Проверяем что createActiveSession вызывался (создана новая сессия)
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(1);
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
        });

        it('Создает новую сессию если активная сессия null', async () => {
            mockDatabaseService.getActiveSession.mockResolvedValue(null);
            mockDatabaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

            await statusProcessor.processStatus({ status_audio: track1 });

            // Проверяем что createActiveSession вызывался
            expect(mockDatabaseService.createActiveSession).toHaveBeenCalledTimes(1);
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
        });
    });

    describe('Обработка отсутствия музыки', () => {
        it('Завершает все активные сессии при отсутствии музыки', async () => {
            await statusProcessor.processStatus({});

            expect(mockDatabaseService.createActiveSession).not.toHaveBeenCalled();
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
        });

        it('Завершает все активные сессии при невалидном аудио статусе', async () => {
            const invalidStatus: VKStatus = {
                status_audio: {
                    id: 0,
                    owner_id: 0,
                    artist: '',
                    title: ''
                }
            };

            await statusProcessor.processStatus(invalidStatus);

            expect(mockDatabaseService.createActiveSession).not.toHaveBeenCalled();
            expect(mockDatabaseService.updateActiveSession).not.toHaveBeenCalled();
            expect(mockDatabaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
        });
    });
});
