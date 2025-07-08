Return-Path: <linux-erofs+bounces-554-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A44AFCAA6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 14:42:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bc133668jz3bh0;
	Tue,  8 Jul 2025 22:42:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751978543;
	cv=pass; b=Hgskh3+OHRstejKVYTcgNwHFKqg1DeGZH669A/GFOz9DF5oS7VOIzRETSKovilLy7vfePaZhHvafhZDty/7lPMoe0dew3CCkk1h0LO5mon0cTiS92jKSb6oCuGOcXv827UCM/VDpFxUxHMpZ+ylIxUO89CQ90vA7VbjSfOVjaoCnP0EakqJxEMzKca/OZvROVxYtGDN31ZagLlDo7rbqqlmYzpdxB5vYw34u/GqAulHuedNjYypS1YS1UlCCXgG6nxviBYTcqxJx36/vO9b/Oebz4GGhtxr0h8WGFL6H8h4vz1ACprxl4uPGfIkuLBbAuG/UnLbbxgEQ0XGDanImNQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751978543; c=relaxed/relaxed;
	bh=XaVkRVEsAed25zjCjiGBplH/4nMg41uW+t70/8AS4vg=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=Irq7ThA43JmVBmPeNQttM+poQAnV/DJ6CP+bfleE10i3apfQZZkPL6DbFCsCEiTll4Rmu/WiVNBVrIhTziO3Asv+0ncSzQFZT/SX1miMkryON8riCDycjbFGwGMBhUVOvdELvKwuJgBTCq/gXvCHs32XU1gjANjmHtoGOOXukHPUhM53mQHk0Zha2qhBpjXnEpzRAmxiHH/d9GFhz9THWEjnZEBCSSjrUTRhI4CkejtIy6kKTBSM5BzJoV+eHBm8282npg3207VwZLoHkySlyx99KuU3HeHzTNaXCVpJg63mk7wgsJ5wQyH5OjBpEPImntstr79Y5WhsHS2fcgegTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=njOe15xF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org) smtp.mailfrom=siemens.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=njOe15xF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siemens.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=jan.kiszka@siemens.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bc1316l5Mz3bgr
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 22:42:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HULofmQBJppw7sMJgXZm4UmJf6jRJCaw0mzjaBonJiOmpEwYV9TjaWncYSZRklDgKyGA4zjfNbU3uAS34L4ra2/hT2LBOvz4HMCR+zJthGF8WzhqH9y8dIiDtWZ9H/VqeQSe/muVxZxfmVGgu+OXji1DGIhpAVyEAQJ8ZT8/al/WqB5a+aU3rtmFLi3ivNHAalbQyb6j5DfnO2mRiBdIQu3l4XaZ/h9+8s/RaJ8nswmdKGK6UMB9258/qdyqPqVp46X5pFy0a2MvvcyWjmyscOF9x2Qx5czD0LkR/i3q/V6F3kyi4k+FozoFbJL/l1aT8Ti82aCqTnHqgT+1Lpw3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaVkRVEsAed25zjCjiGBplH/4nMg41uW+t70/8AS4vg=;
 b=G2N3rNSXpGQEtnjfIl0YMGe0xQxb3evxMeS2/VdMGSkqSuylaKnvbu5xqPlG9uwaIfs/dbPu10NqOHF5NxnrgdYUZme3fxjuQCop/6OAN9l3d0mVvvTlxmnAfCcAxvSUQ5C/AKgSoZcdDLaBugd1uhhjrNBG1fLIW0b9ZoSj3etcY3LX+nV4ObWNM1vSxd6IDeNzldQs4upkJKg4oRj8VWrKnFXvJ/M6UFHNAKGLw7sgfRwhHmTpc+A6aTAMOd9o4zIH94c/F3gnEBj9FRvjHheiPLeFz/ipJIUBZCy+idoErLsFZrt3osHvD5Qio4XNqvuacMXZs9On7gADr1lKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaVkRVEsAed25zjCjiGBplH/4nMg41uW+t70/8AS4vg=;
 b=njOe15xFdqknAS1mXJN+Dtiiqs124R8VALf7UfI1BhgHGlTqEyY5z4dGZ4RLSXUxUtXw4USu4GTzYTkA7SDbdCcDkYYr82oIVdUIKY2GIvOP2P85c28KYBPSnb2prCAo36EtZ5rHT8F4aBpMaXK4TXGfYTlLqwUEPfBqANUYA06gumACtwYV05bS3A0MYRG6qI7K6hgFRct2RnicS42byjW4lEvhl+n9Amr2T7QI7uQT4yojyYDA0jtOFyjnyUjt+td9ecrzKrF97m1b2S/6bBwVMvbpM4GIsj+D3HbZ/U/6U0lLIy9pEaxriWtc4VV+Y73cJT8H/jgEi41zCYh++Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 12:41:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:41:55 +0000
Message-ID: <38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com>
Date: Tue, 8 Jul 2025 14:41:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Executable loading issues with erofs on arm?
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: d5049439-1259-4eba-fac5-08ddbe1cd271
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0dJVS94VFFYeGQ1QTBGWFIvU0dHd0FkcUZnRGdLWTBDZTFsTW0vclQ3aGs2?=
 =?utf-8?B?UGpyRTNlMCtFdXIzcG0yNzJVb01EVGNyR21yNnVCSXVVRGxpZmJ3RTRKaENY?=
 =?utf-8?B?TWtoRDRtRi9YbmsvRE1nZXlJSkhsejhheUpuT1d0ajBEOEI3Tkw4WXdoZ01x?=
 =?utf-8?B?cUc3aE5hTzB5VkFGZVdqSm1wNXlOc1pSV1o5d0pJYm4vTGFXS0RkeHN3YTE2?=
 =?utf-8?B?bXA3YjFOa3BvWUlwL29kV010dFd6K0RMK2tuemczWUhOZ21KeDlBSkVRUlZD?=
 =?utf-8?B?WkdFRXppc2hGT3VaZHJka2t5cGtWaHFhVUpsYlFHTTBmbzhpLzRiZkVEbitx?=
 =?utf-8?B?QTJCRXExUEczWGVwMThHUU5vTW15eWlaNnhGeFVUelBTNzVWV0ZSbU5hVEc5?=
 =?utf-8?B?RFhmYmlreTN4RVNRQzVCaFo4cGNzUWNOQ0o5Q3oraitnK3dPUGlvMHFMSm16?=
 =?utf-8?B?amtWNnFuM1RSUXJoYlJ5YW9uRkdVaGFFTTc4UElEMWVyVXRDdzBpSWhkTXlQ?=
 =?utf-8?B?Z25yYWVTcTZtR0tpWXdrY3NlV1JONDlQbVcxaVcxMnNQdFBwM0I1VXY0YlI1?=
 =?utf-8?B?cURoWGNhNUpxTEd5T0tMdTVEWVlWWU1iOTh6dkZGY1B1eGN5TmV4c0E5M2FO?=
 =?utf-8?B?ZzV5M2xWdEFUeTBFN1N6Mkg3TU0xM1ROYWduN2l4cm0rUzQwTFBTWmVwWlE4?=
 =?utf-8?B?dVk0aFFzdDZZWXNhdWtLeU9SV015eThSb0MzbmRyL3crYzJuZUtpREhhamVi?=
 =?utf-8?B?VEpBeHhDU0IrNWFqT2R0MHZVZjZoZVBuVlZwSU04WVlNWlJCa09aTEx3bThT?=
 =?utf-8?B?elFzN1BWRmpUSzIvSk1iUmxoMlZ3aThPWGhYNWpZMHFQUmFVQnAwMjluUmlS?=
 =?utf-8?B?a0IvMzNoOUFNcm5mQStFc0F3Z0pjTnIrdlN1L0o4NUFIRlpqOHVjUTgxTWpE?=
 =?utf-8?B?YjM3VzRtZURMOU4xU1hMSGU4QU5hUm1NYkxUVnphUnlSSXZTWEZXdi9oQmE1?=
 =?utf-8?B?WmtHaTVCbXk0TXRROWRDTWd1WnljemV1Sys4c0Ntd3Q2Z3lrdnpXb1BaaEU0?=
 =?utf-8?B?SjZ2eGZyWFhCdzlHSXZhMHRPQVd6VkR5eXlKeGpYaWttRXNIRVp1dklpWG1C?=
 =?utf-8?B?bjR3bzJhbS9uMFFrcC9nVHBScnZKNXRzbWJURHZ0THM0b3M4ekNIenI5Q3Fy?=
 =?utf-8?B?RGNselRyQzQ5c2prMEg0bUl1bGlDWVE0dnBNRXo3WWo2MVZQU1RKeEpKWk95?=
 =?utf-8?B?VHBCaEtYWTZnenJROERzbHc3UXdWOUcrR0dSVWhmL0VkRTlzUGpvQW1KeWtm?=
 =?utf-8?B?eEI5VHNCK1NrZCtiMmUrWjQzbHZ0WkVNV1RTYmJRbWlzYnFlRERIKzVIczh2?=
 =?utf-8?B?NVV0OWxlaU0wdlBQWkR4Ny96eHpOWkxKMzN1aWN2Y1h2VEN1MUNkdlc0dDZW?=
 =?utf-8?B?ZUVxSmZoKzU3Myt3dEVhYzE0R1Z1OVpnU3JRR2xYNXdIRHp2Y2orWW8vNFdz?=
 =?utf-8?B?SlNpbU91T2dRK2kyK2NoYy9PVkNCeFpQbEpIT09YMGE2TnNkSk04VElxaUNy?=
 =?utf-8?B?YUdvUU9EQ1p2bGZ4WnNsMWdQM3hiMGNTNllWMFRjbkRqY3RwVnNBcXNEbCtQ?=
 =?utf-8?B?RUY5YUVERWlNZzZORE43czRkKzJFZGFRZXdwbVBhVEZaY3hMK1hVSUpySllv?=
 =?utf-8?B?UnBZcXl5L2xnOEt5OGJvOFU3R21BWnhocGV0ZEtLemR5N2Q0cUNLTzU1TytH?=
 =?utf-8?B?Z1VzY1ZEZXVDSmZSRUZxRHB1KytXSWMvRWE5aEU3ZnlJak9UMG9qSTlhYTJh?=
 =?utf-8?B?VTQrRGloTGpKZFpNd0VTNFZseFpFNk9GZ0NMYXVCOFlKa3grcm5UQmx4bjE2?=
 =?utf-8?B?ZjR3UDBueTRUQjZYOEZTSGUraDV0cWwxMUIySUVrR0loN3I1eUpkeUdMTGh1?=
 =?utf-8?Q?UMQfUU89nWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhQa2dnVHcwWDF4UWZYNkllUUsvWHBnVmkzWkpTUm1PNFo2cVVyY3dUQmtY?=
 =?utf-8?B?SEd0RXFZa3VIbHVxeWR5QjN6eVpELzkwWGxEazR3Yy9ycDlBR0Q2QmhEWUJ4?=
 =?utf-8?B?UEZDM29SVFNNWGZSRnZPbFV1SHlnZWxmZFNVTkdJbXhBNlp4U0d3VmVoQ1pJ?=
 =?utf-8?B?MFhCYzhnN1JSZEpUakhQMmo2eFZhaXZOWU9jemlHUGdwbFF2dFNvZ0J2ZlRI?=
 =?utf-8?B?R2ZYRUI4b3FvMVp5c3REUU1QTFVkSW9rMnp6UERtMUFkZFRFNW1tMCtCK3Bl?=
 =?utf-8?B?RjRodmVQQUFoekNsYy8xeHc1NFE2WnM4Lzk3Q2RyUEtxNkx0eVFNR3J0YlNi?=
 =?utf-8?B?Z0pDTStGV2VxbkRtcmVVQ3NTRGlJYy81djJaaWxYcUhXRE0vcFBZR01iNEJk?=
 =?utf-8?B?a3cyZWMralNFUHkxaEhHa04ydDlad01aVyt2TXlCTGRtc1F6d2tWOWtnbzNV?=
 =?utf-8?B?YlV2dktNWHhIdjRGTW1jSkkrb0JiVy9hK2pIOVhWUEdkK1dUekQ0UER4NDJC?=
 =?utf-8?B?bVkyazJPd3pabTB1WGVubEVsd2laY2xkK2EzOXpDVS9YVzRtOHArZ3JGbDFh?=
 =?utf-8?B?Q1FQUUZaZ1BqcUFyNjJrSnNpczBTaUpnZlM1MmF4NFR2cnFuMlo3VmoxTVhT?=
 =?utf-8?B?MStsVnQzVGN0dnF3NERNQllmOU4vQjRGbHpXQXlmcVhWM05zVkltRGZQYnVV?=
 =?utf-8?B?dXNQRmlhVW9aS2N0bVBXdElaMHpQTzBJck1zeWRqN2lxdHcrK2tsYm5pWXNM?=
 =?utf-8?B?VE9UQWx0M0F3d2RKcTY0cC83Ui9RcEVMYVhqV1gwRW9ZUE5Pb0kyNFdHVkZG?=
 =?utf-8?B?Um50MDlYR2Nsb2htL2xuZmtDM0M1bGJUYmlmTWJpN1VFUnR6TUVvQTBKQU5Z?=
 =?utf-8?B?QzZtVXZTbnd6cDVManNvc0RnQXJ6RTVVVXQzbWxWeUNSSUdhK1lLQ1lEWXYv?=
 =?utf-8?B?bzEwOGlEQzg0QVlJTE5wQXExQ2kyKzQxejJPZTJZcTFCR2NTVkRLTU9kYzdu?=
 =?utf-8?B?a3JheW1qamJJWStPYWNQZUUyNTJpNFRyTW5tUC9hSGRmNnJ6bklBclQ1dStO?=
 =?utf-8?B?MzNjeEErQXdTdjFERThkQWJXK0VqQkRvSHZmcWJ3TlBnbXZIWmRIbGx6dkhZ?=
 =?utf-8?B?VHZRMHJvUTZTcktmdFgzdmo3dEc3SU5XQ3BmVGl1NWp3ZElIRDFKNzFwSWc4?=
 =?utf-8?B?UGIwN2R5dlR2UTAvMmlDbmdiNTlEa0xQaGxVYnloZkY4OVhDekxMMnFmSkZI?=
 =?utf-8?B?QzVSYisyY2NwcXdqM2F6R3RKL2NsVG0zVCt4YTBKZzN3RkpvcHdyMUF5Uzdq?=
 =?utf-8?B?aHk5dzVSKy9tWEJGZkhjZ29DTXZsTFF4YVdwdjgza1dyOWh5eVI1bkZoY0lP?=
 =?utf-8?B?RnhRQTgrTkNBL3ppT2NTc01WM0s1UzF3TmpJOEFmK0RzZXFMdGE1T1ZqWXo2?=
 =?utf-8?B?OFpWT0J1KzhtcG05d0ZDZWtYaUdlQjVMSWdVVi83azRNakxtSTIxR1JrVFRU?=
 =?utf-8?B?enNhaW9lUml2VThlZC9BSEoydy94NkJJY1dBdEJLZ0ZUNmpHT0hiRTk0VERQ?=
 =?utf-8?B?dFFuUGFUYmFuRDlhazJ1eXpVZFVESU5FcEFMVnQ5MG1VVXZZZXJ4RnM2R0xV?=
 =?utf-8?B?OUdzRlBDaDYrMmt0bCtLQWtDRG9ZUkdML2tXeUprV1VqVFYrSUUzNlh4VGNv?=
 =?utf-8?B?Q3BwemZ5dU95bUVOTUNuZUxIb25NWWN5bEJ4VGpJZmhqWkwrOVVFUHVEMGdM?=
 =?utf-8?B?NXJNVDRSR1FxbHFlRVR2S3doeU1vMnhaR3V1L2VTak5Vem9yazZ5RXhqYXZa?=
 =?utf-8?B?UUhVa0hYeWhJOUJ6ZGlURmVITlFiUno4aGF2L1RQSGlhbjc2a0dpNXN0cjYx?=
 =?utf-8?B?U0NvTTR1L1V3S25PN0ZBQlRmblRJeEZKZUJxQ1BEeE5nTGJ2QjYwQUEzTE5p?=
 =?utf-8?B?cUJMR2dUV1ZtUkpRd0l6bWQzcklpYzBva0pSNk9aTUFSc1gyelhLa0N6cHFF?=
 =?utf-8?B?c0lhbzhCUnN4YkZqZ1orT0N0c2REQXpJN2lFLzlqQnRPcFQwdzljMHhPYlhM?=
 =?utf-8?B?RVl4akJISE5Tcm81Z2dHeTUvOWdzMmR3YUZtTGlrK25zcmhUenU2L2RWUFVh?=
 =?utf-8?Q?qHGk88B/jBIcaR5x0KwLT2iAX?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5049439-1259-4eba-fac5-08ddbe1cd271
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:41:55.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VpO+/w246T6yDB32Pzt/+tlQRnko3TSoAmLD3M/u5EI9CflezYzKAkQ5XZ3dGLT9f5f9rYkN3znaIjrt7KsjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7155
X-Spam-Status: No, score=-0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi all,

for some days, I'm trying to understand if we have an integration issue
with erofs or rather some upstream bug. After playing with various
parameters, it rather looks like the latter:

$ ls -l erofs-dir/
total 132
-rwxr-xr-x 1 1000 users 132868 Jul  8 10:50 dash
(from Debian bookworm)
$ mkfs.erofs -z lz4hc erofs.img erofs-dir/
mkfs.erofs 1.8.6 (trixie version, but same happens with bookworm 1.5)
Build completed.
------
Filesystem UUID: aae0b2f0-4ee4-4850-af49-3c1aad7fa30c
Filesystem total blocks: 17 (of 4096-byte blocks)
Filesystem total inodes: 2
Filesystem total metadata blocks: 1
Filesystem total deduplicated bytes (of source files): 0

Now I have 6.15-rc5 and a defconfig-close setting for the 32-bit ARM
target BeagleBone Black. When booting into init=/bin/sh, then running

# mount -t erofs /dev/mmcblk0p1 /mnt
erofs (device mmcblk0p1): mounted with root inode @ nid 36.
# /mnt/dash
Segmentation fault

I once also got this:

Alignment trap: not handling instruction 2b00 at [<004debc0>]
8<--- cut here ---
Unhandled fault: alignment exception (0x001) at 0x000004d9
[000004d9] *pgd=00000000
Bus error

All is fine if I
 - run the command once more
 - dump the file first (cat /mnt/dash > /dev/null; /mnt/dash)
 - boot a full Debian system and then mount & run the command
 - do not compress erofs

Also broken is -z zstd, so the decompression algorithm itself should not
be the reason. I furthermore tested older kernels as well, namely
stable-derived 6.1-cip and 6.12-cip, and those are equally affected.

Any ideas? I have CONFIG_EROFS_FS_DEBUG=y, but that does not trigger
anything. Is there anything I could instrument?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


