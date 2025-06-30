Return-Path: <linux-erofs+bounces-500-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F2297AED1FC
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Jun 2025 02:36:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bVnKg3mbYz2yft;
	Mon, 30 Jun 2025 10:36:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c409::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751243815;
	cv=pass; b=afLMh8LTQ4g7kfNUgbPbHDxPS2EBD2sqtxi6zUDDFciElcCrZyZxGdUsWefTpowZc63qe0ktQNJZYpcy4B7yS3WA3Q8AmW7/tF08SShE+y0lNrAcTVHz8UGK4y75ciF5uVPz/EdjbIAPOY/UfCP2jP/oJoCGxL8sdliLvlegsuA7C8zjMydJP2sKqPgAiz2K52VQQMsL90Dyn2KnNsHt/yl/iGVq4C3js2fjOYEo1Pk5S6AufJ2uQgT8pIo9OZd/EAARh58bNjGoptvJopRe8L2XK+KwpykSREp7K0hdXrtew7FMUWUcjFGuaXYfl/2S7/nQLPKkaO/SO+/NCRJ5Kg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751243815; c=relaxed/relaxed;
	bh=3Jn37wN+1hrU1h3yUgUo++7U0zTXvAzhQ10Lmbp+eRQ=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=WtUK6aizcdzmolwu1f2T16a+rk9+Q5qNztHNI34WZrtA3V5YXJVadFNvRqzKC7/Axo50We6LHTjsCa5eRPZMK0Sin9qkw8FJuGatmVk4W9kikuRCkXVMNoGpoVCWOnGymm8/3IhSob11tDSGSW1JriR4IKQfdJTbFjt5nm0hapZBN7R5EGNSzu5CB9Ww3oaZDHrjAC6i3bELEccv7zlJeUW5yO5eDD08L5R7O1J/G9hk8rZ3bymGJn/a2w31VU+WpF8DEMq/n4zmuZkqyX2fEJw7a0yTGNzmDIGgBvMLTog+4fmUPlrVTbiJauDKkv9I4bitQHn0V5xfflSswD7m5g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=occurence.biz; spf=pass (client-ip=2a01:111:f403:c409::2; helo=ma0pr01cu012.outbound.protection.outlook.com; envelope-from=amelia.robert@occurence.biz; receiver=lists.ozlabs.org) smtp.mailfrom=occurence.biz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=occurence.biz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=occurence.biz (client-ip=2a01:111:f403:c409::2; helo=ma0pr01cu012.outbound.protection.outlook.com; envelope-from=amelia.robert@occurence.biz; receiver=lists.ozlabs.org)
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bVnKf4dF7z2ydj
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Jun 2025 10:36:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7sAwndiAjlOxIYqTNZt6g5EV/OiE1yZahD1Y0jOcQJIiOXNOK+JlWyd6i3E1/OXoEh/hV5nMowUpogMo8JcdVSjBRhnVc2TVL5raMQgvnhsKyjCZDSUvg+GdytVNuvufOZerTto18In7uOotXl2Ull0DVBMJJtEN3Az4A9PUAnri9fntOky2Y2vcy0q2czd0+GK11bb9Hlh5+9nEHWB2t+KVoB2ODpu72Vr81KffFf88SGRBd1i6a95aHHwv1KLOlQ2/LM4aFsXgFeZeBex/qACy6WCqcUxgm+qYooBB6Ya7EePcSmEPk/3bY5U3ku87vgpXI1j/WjXD9T3IjcQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jn37wN+1hrU1h3yUgUo++7U0zTXvAzhQ10Lmbp+eRQ=;
 b=qqe+V+o5Aa/NZ09qUOzk3mOvFg/Ewitz6BTNPoOm2qbZC6I1+9ylj6LtFdVMxVxtw2NOPRXnknKHPJ+5WSo+kNkGEPq4wC6O5cZ5bfPzAmrLBjHhTrmseiYpAIRQ1x2CQxw1uGZGcHhTkEB3UyD2X2rqzI0wb2ecfGCsKvxBCxuhMp9uMXbC6svuIbAmkSoeBCq6ND4afLw7Zy0Bxo7ijDjZT/x/5viY/RYpv6H6/bU2PVkx87osPkRNLbckUyKldTGGIpHEp52/IQC9xemZR7q4x0n5b2T736B21h59HGQsRbMNu4Hb1mAfxdBsckVXDTkgfAt262HizK5R+1EiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=occurence.biz; dmarc=pass action=none
 header.from=occurence.biz; dkim=pass header.d=occurence.biz; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=occurence.biz;
Received: from BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:6a::15)
 by MA1PPF6ADF4B3A0.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::95) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 30 Jun
 2025 00:36:31 +0000
Received: from BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::51e3:b54f:af3:10bd]) by BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::51e3:b54f:af3:10bd%6]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 00:36:31 +0000
Content-Type: multipart/mixed; boundary="===============7425046866141026154=="
From: Amelia Robert <amelia.robert@occurence.biz>
To: linux-erofs@lists.ozlabs.org
Subject: LIBRAMONT - Agriculture/Forestry 2025
Date: Mon, 30 Jun 2025 00:36:30 +0000
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:6a::15)
Message-ID:
 <BM1PR01MB3316491FD2B1206E6F5CD4B9FF46A@BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB3316:EE_|MA1PPF6ADF4B3A0:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d1e965-6afc-4b26-e516-08ddb76e288e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|4022899009|376014|586017|366016|52116014|10070799003|8096899003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHlXUFRzQUxVaE04cVlmbkpBZ0lJVHk4VEpsOXFLc0duY05UbSt4dnhWZks4?=
 =?utf-8?B?R2p0UnRZdVFzQUhScTdBUUlSajdqVVp1azB3aUJTWHViRjM2cElSRk8xeGRB?=
 =?utf-8?B?YVVoeXRLY040Z0JwaDdOK3hZYWtQeXh5c1NrM3p4cWh2eXJiSWdRazBqNGVR?=
 =?utf-8?B?aTlkemx3R2pGTDlMQ0JHQ2w4L0U0Sm5wZTcwdU1hUEh6Y1A3NEtPUnJsUXRD?=
 =?utf-8?B?MS8wRzVVa1c5ZjBiLzFVOCtPbXlOZVpHMyt0Z1JQVU92TWNFdVRhbWtNYzJy?=
 =?utf-8?B?TTdxQlh3VTlxZ0tucVdIZmtxODAzakJQQmdwOFZheUVCdDVHOEROUW5Bbk1K?=
 =?utf-8?B?eklQMG5BZmlic1BpQ1EvNWRZdDg4NS9mb25SZ0lldlY4UzBMcXdxQW42SFBs?=
 =?utf-8?B?bmNlWEFmRWV4V2Z3QUMrakFMdUhRRXNCcEZuVVpIV0NEdVpXb2pQQ01Hblcr?=
 =?utf-8?B?clk2S3g4cWlXMTJHZmZrU015RkFIK2tJanJKOFpyb1loNzBRWTIvRUNNQlFL?=
 =?utf-8?B?R1pxVHQvTFo3WDZ3ZlpONzNMd2ZKRS9OOVdUYU5FcWhKSFhBVzJ4VEFEUm9V?=
 =?utf-8?B?YkcyU3hnaERZQm5DVGE4SFViWkN6WUQvK0J3RHFhSC8zV0FTd0ZwY3NuRElk?=
 =?utf-8?B?OGdSUURabXBBV0ZDRkNjRFhwSWRYTXVxdUNISEtNb1pDSWlWYStnUGtvSTJH?=
 =?utf-8?B?THRJd2NOR3o0TjJuNWNOa0RWcFhYcklWeFEyQWgrNXM2NXdWZFJWcVNhZW5O?=
 =?utf-8?B?RUpIbk1adWZiOUdrTEVkZXRLbWZ0blNDeHhyVmxCTnNHQ0pVUVJOOU9lQlNK?=
 =?utf-8?B?TURNaTBVRkRQQll6ZWJaOXFRTVRlcW91TTlsVU5NRXVOMW9XdHUrKzBURjVM?=
 =?utf-8?B?N1pFb0RicEFHN2xtNG55ck1zZUdSdHN0cWhXZ0tYcFlHWEJkaDhSNzJhaVFq?=
 =?utf-8?B?ejR2dnFQUEJHc0h6Mk92TG1tbXI1bE5hV0VmTjhEaGVQNGVFbTI1RXZiOGUy?=
 =?utf-8?B?Tmtya3U0UU4xUS9BWGVZUkxhaEJqSzluUnRsV3NVWDYzaGhIOWZLNFlzNXN0?=
 =?utf-8?B?N3VBSVR6YnhBTDQwbWkwT2w0aDlzL25EQ3dCVFRFdUVvMTBaM2RCRGtOVzY4?=
 =?utf-8?B?eHhVbHJWRFhOVHhLNzc1U3EwbytCUld1ZFhlWVNsd2NOVWU1TzlSU3FlYWg1?=
 =?utf-8?B?YUdTN3lYM1E5MWwzckZOWi91M2Z0M2NOaDdKYlUyODJFK1gzZm1sMUJRLzc5?=
 =?utf-8?B?RER1SW9aNFRPb1FBVkVOcGNVVkJuWk5hQm5PVWQ5ZmVNNzVPTlBvdGxwQnRH?=
 =?utf-8?B?ZjlkeFd0ak82b2dqcWhHQ2FDZk8vNmtvdzlRcXlOTFFzcTBpSXA4enlicUUw?=
 =?utf-8?B?R2lXd0tQWjk2OUtDcmJLemoydHQrdUloVFd1OXI5WTZpQU8zL05sVisrb1h2?=
 =?utf-8?B?Wlc4T2JWam45NHVQMTA3Z0JrR0cwSmZmMU8vK1VNeGh4djlyRTJFNDg2cUQz?=
 =?utf-8?B?MFBva2NRWm5KWTl2d1R0QVFndEVBekdHbU92N0dXOWVXSmRMUHRuZ0djaC81?=
 =?utf-8?B?MVpUQmhZVktZMXVMVjFheTJOaDR4LzFkTEVhQ05jMkhDZisvb3ZpbkNrNkpH?=
 =?utf-8?B?dVovSGxPbS84blkwajZ3YVhEZmluYTFaRWhPd2hXWWlFa1lBck90SVkvaUUw?=
 =?utf-8?B?UGphZzc3R2VOTi9VSnRoNmlBdEc0TG5od0hvSWppN1dBQ2xmK2NSZWtUZ0VU?=
 =?utf-8?B?NXhNTCtVS2hHWWN5dDQxVWxpU08rTld4TFFXSkw2N2lvWXorN3lvS2p5SmlM?=
 =?utf-8?B?ZUJtcGtxVStmcm1vMGNmTXlHdTNveWdxR0tvNHlDSFFsNUpmdmkrV3BjUGx5?=
 =?utf-8?B?cGlPdzNqMWtzVldocHE3bFNHMWNrVHg4YjhiVUQ3Rk1YeXRueVBldkZXMHJO?=
 =?utf-8?Q?4xlUuWKVcxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(586017)(366016)(52116014)(10070799003)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVZFQ1E2MWEydTZzVDVkVE1zQU5xMzl4S005eUsrUHhGelAxWlVHNU13cU5N?=
 =?utf-8?B?M0JUMkRhcXhWYytFMTZzejNuSDBzVnJTdkZiTEhxdlNwaDIzSFNtbmVwK243?=
 =?utf-8?B?NnFkT29TQXNudGVkck01dmxtYisyK0lLZnp2NDc3ZitnYXd2RW4xanJMMkZ0?=
 =?utf-8?B?WUJKOVRNYTRsdHFnM25VS0pJTkFuTkQzVDZjeXNlaVJYUkpKdWFoVTZPdzEz?=
 =?utf-8?B?TmRyUzlrSWVHQTA3UDdoQ1NLSmp4MnZuTnRCSDhaTFhNUnBydnBBY2pGTkYx?=
 =?utf-8?B?dENJRXVrQXFlOUV1Ni9YZVZMNkgxcDV0ampHWTBLRmVLRnNsSWJjWjQ0am9u?=
 =?utf-8?B?MzBoUnJ4MG0rU2QvVWZmbkVHU0tyempZT3pmMndoZWlMVzdhWEpvTTJiTEQ3?=
 =?utf-8?B?MDZ2VXV4RW03UlZ2SjJMRkUwT044cFM2V3VFc0laOUdqdGpmWVNnaG16ckk2?=
 =?utf-8?B?OHpwZ21ueStvZ1dieUp3WDlmRnFKYStRdU13YmtySStmRTRQWnpqa0c5Mkxr?=
 =?utf-8?B?ZG1mdStrbmtIbDZvaExuVUc3SkdZSTB1QlBRU1RGempibVhZRGxaRVk1aWgw?=
 =?utf-8?B?WkE2bmNVZnM1TG4vbFZ4YllXRGNVT2kxWGpuZXZRZ05VaitEZ3R5Z2ROSjhC?=
 =?utf-8?B?Y2tycjhiSHk4YTU3d0NGWFZicUs4S0hjMzl0WFA4Rlg4eUw0TU14RldJM2tG?=
 =?utf-8?B?Y1BLNnNLekxHZGlyeFFVRmVWbkJ6OGNHWGE5QmRESDFVKzV5QXRJdkxxMTM5?=
 =?utf-8?B?ZDROT1VrU3BVVnE5SUZqTEg4VUlDS3UvOWFvQlJYbzZqUVpLSFcyN1dTYUpG?=
 =?utf-8?B?R2ZDcXp5alB5cGFMOTEvWFFxMmhlQVp3MStnRmVZYlo1WXcxS0dSMDNRQi8r?=
 =?utf-8?B?SW5icFl2N1p5dHdvRi9NWWwwdHRueWo0K0hGcFJ6N2VsakUyU09jK1IzNk8w?=
 =?utf-8?B?K0dkVjN6ZUxvVlJueVNjNEFBb3Q5MmUzc2JkdnY4S3laUVFLZS8xSXMvMG5B?=
 =?utf-8?B?b25MT3RPTjdtVWt6aytTQ1ludFN5ZTdKc3U0TExKWG0zdThlNTlCWXFVUGZO?=
 =?utf-8?B?WWNsNlVtWGsweDlOVE5pU1JoOTJ4NlN2L3dlYnhoWi9qWmJBRVhHWmkyaHJj?=
 =?utf-8?B?a21JR3RjWVBxakFTRjdvNzNiaEY1azhKenBOYVVKMFYxUXY5cmcxcFFTdE1h?=
 =?utf-8?B?aktoOWlHenhneTdTeitOSS92c3NzN1NFN2MzVGNTUk9Ba05qZmliYXNxT004?=
 =?utf-8?B?RGlMMDhVYVV3UzJWL0gwaGRORTJJQWFYdVZYUXdlbEFiUGhmVHBYQmNna1VB?=
 =?utf-8?B?YVAraFFDR2s2QUtSSGlPWC92dTJmZ21NdzI5U2pQanhsSDNRSlp6VE1jYW1O?=
 =?utf-8?B?Z3pkKzRYb29rck42YUxaWW5LNmpXblMvblMrQ1hsMGE2alp6VExSNlIzcVpE?=
 =?utf-8?B?SFZzTkVKYmFRTHpsODBCcmtob1BRYkpDS0dMUml0L2E2YXA5bEZqY3dUVnZh?=
 =?utf-8?B?b2xVd084TDh2WjNIZjJ1NFNMTXp1aFlUK2pUOTFnbm1zYkQ5OWIwVHZGMFh1?=
 =?utf-8?B?TTYxWUtoNnYvUm1tSmJRZVQ5dVNJdkJZdXl4QXFGZ2lPNllPSHZybTNRL1l6?=
 =?utf-8?B?RlhOTzJqNWFvSG5NUkR5VXFzRDgwWVBFNzhSYXJ4NGMyN1JGMExIT2VNM2pt?=
 =?utf-8?B?M2JWV0ZhR0F2WGFuK0MrWnZnaDRvQmlyOFVHWmRTcy81ZWd4YmFTdkE2V2tY?=
 =?utf-8?B?Z0R0VWZUQXd2S2RmSTMwaUwwamRaSzVEUjBIVjVOamJrM1ZwSUpXUGRHd0U0?=
 =?utf-8?B?TnJ3V3p6YmhaVVZnQStycDNPbTJLWGxtaEdINnZqdURPTDNhbnYxaExVVHlx?=
 =?utf-8?B?RnBqLzdYcTJiMCtYblUvZXRsQkF5VFlIUUxjVnRhR2h1Qm83UFVndU9iM1Bt?=
 =?utf-8?B?YXRMUUpoVGx4UGh0eWNhdjMxeHg2U0NhcmJKMUZ2Ynd6V1BwK2ZvR0ROZGpV?=
 =?utf-8?B?bFJQalhTNE9jZkNmUmhQRlppMm1sOFdDVkUxN004aWNqYTJKeW9IYjBjRzdv?=
 =?utf-8?B?VkVmSDlDOGhTbm1iaE95am4vblRGZFo4eFliNkVBdGszSUZHd0tFUlp1UnJN?=
 =?utf-8?B?WkxvaDJCK0l0VmFtYmZ0RkFjQ2tUcUI1R1VHK05xMmY5bStRUjdQcnNDVWFQ?=
 =?utf-8?Q?yddD/8pBSfWk26GqKJzsaeY=3D?=
X-OriginatorOrg: occurence.biz
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d1e965-6afc-4b26-e516-08ddb76e288e
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB3316.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 00:36:31.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0ad779cb-5dfe-4306-9b67-8b37980e7d5d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oed3R9LSYJNAg6CN10epBi8hRA6Ur48MPsiRKlSNol/PH0zftdC7oxI0vmWVe2klNOCEa/lkNBDQA3vre6wauzdbHe8X/qNj13Z9qCNFoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPF6ADF4B3A0
X-Spam-Status: No, score=0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	FILL_THIS_FORM,HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MIME_HTML_ONLY,
	SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_LONG autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--===============7425046866141026154==
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJz
ZXQ9dXRmLTgiPkhpLDxicj48YnI+SSBob3BlIHlvdSdyZSBkb2luZyB3ZWxsLiA8YnI+PGJyPkni
gJltIHJlYWNoaW5nIG91dCB0byBzZWUgaWYgeW914oCZZCBiZSBpbnRlcmVzdGVkIGluIHJlY2Vp
dmluZyBhdHRlbmRlZXMvcGFydGljaXBhbnQgbGlzdCBmcm9tIExJQlJBTU9OVCAtIEFncmljdWx0
dXJlL0ZvcmVzdHJ5IDIwMjUgYW5kIEnigJlkIGJlIGhhcHB5IHRvIHNoYXJlIHRoZSBudW1iZXIg
b2YgY29udGFjdHMsIGFzc29jaWF0ZWQgY29zdHMsIGFuZCBhZGRpdGlvbmFsIGRldGFpbHMgd2l0
aCB5b3UuPGJyPjxicj5UaGUgYXZhaWxhYmxlIGluZm9ybWF0aW9uIHdvdWxkIGluY2x1ZGU6IEJ1
c2luZXNzIE5hbWUsIENvbnRhY3QgTmFtZSwgSm9iIFRpdGxlLCBFbWFpbCBBZGRyZXNzLCBQaG9u
ZSBOdW1iZXIsIFdlYnNpdGUsIE1haWxpbmcvUGh5c2ljYWwgQWRkcmVzcywgQ291bnRyeSwgQ2l0
eSwgU3RhdGUsIGFuZCBaaXAgQ29kZSBldGMuPGJyPjxicj5UaGFuayB5b3UsIGFuZCBJIGxvb2sg
Zm9yd2FyZCB0byBoZWFyaW5nIGZyb20geW91Ljxicj48YnI+QmVzdCByZWdhcmRzLDxicj5BbWVs
aWEgUm9iZXJ0PGJyPk1hcmtldGluZyBNYW5hZ2VyPGJyPjxicj5VbnN1YnNjcmliZSB8IFJlY29u
ZmlybQ==

--===============7425046866141026154==--

