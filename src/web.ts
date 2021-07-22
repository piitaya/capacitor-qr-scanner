import { WebPlugin } from '@capacitor/core';
import type { QrScannerPlugin } from './definitions'

export class QrScannerWeb extends WebPlugin implements QrScannerPlugin {
  constructor() {
    super();
  }

  async scanQrCode(): Promise<{result: string}> {
      throw this.unimplemented('No implemented on web.')
  }
}