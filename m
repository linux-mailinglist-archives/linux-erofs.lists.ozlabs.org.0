Return-Path: <linux-erofs+bounces-496-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4BAAEA866
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Jun 2025 22:47:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSrNZ100Cz2xS2;
	Fri, 27 Jun 2025 06:47:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c409::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750970862;
	cv=pass; b=Ya7oDwDCFi4Hr0cfjfog24HEc/wpI80e4c1OcJaqs88t2oQjBar/Y/UyI3OIN0/l4PWRECxPEG5OQlqZftEJH2BmDTCU9fbeqWmFjPN81XcGpRwCsTdTVy3XfcCPKu371IDjnQQ+rEVoGEwBMvkVjho/Ujj6D6kbXpmUkZ51y9nMBonkX/EOjILaaCspk8XFO4jcajyN9vSFyh7WJpEPVjeSry5MPH73h7buz/3gpVOVyvNv6UWmu+jNQamzujdQs/FmUlwYdOeKbXraAAiDuPCAiSvW5k/Pc0qFmqBA19rAdOaVC7vCFGhAc4Cc/jmLQ3iMzLJ8SR/CQ7y9XinfWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750970862; c=relaxed/relaxed;
	bh=EZxvxdeHAEPrzDdSDYZNdg+Nj+o96vXi3nFp1R79ftg=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=MyhaknaJIH96+kMO3we99eFBZImyEOQ0CRZXNeebSEMJ3wY/NN4pQNT4c5o3Gx+N813tJeYAP90TW34ir1dE0xkSG4aoICoDdn+t8dmI+REwPCqOnzDYmth+b+uUz7TC/jhisX873mce7lFeGEfj0sqczvepB/UXu6fBjCbHCcf46moY6eQ6eWzT91hcwRvJ3KSVM1UVvuW40GxbOV1bm/OBDgyscYF00QbWcyVNO4BhpSsaULLfu6/f6Z3oQeZ8B2v1iRfQIa35AF4o0O5Z7cRoDXSK9PtPx0s7CF9/5Xd5pDwgg4l4aLV3UxBfaS9zbro9mu4KQPjhHL2s077Szw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=flourishdata.xyz; spf=pass (client-ip=2a01:111:f403:c409::2; helo=ma0pr01cu012.outbound.protection.outlook.com; envelope-from=min-jae.choi@flourishdata.xyz; receiver=lists.ozlabs.org) smtp.mailfrom=flourishdata.xyz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=flourishdata.xyz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flourishdata.xyz (client-ip=2a01:111:f403:c409::2; helo=ma0pr01cu012.outbound.protection.outlook.com; envelope-from=min-jae.choi@flourishdata.xyz; receiver=lists.ozlabs.org)
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSrNX28r1z2xKh
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 Jun 2025 06:47:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5qcUxHiIXj/loyPPxdXQJ5lt43NPdAMCyKLwaVrAt8eB07IR55KgMHjUYtp2qd22zG1UG4UziflTbashEaZhsWRH3veIqd51L0e/sxWN+bmZcvjpffI5FAkWERRCoKDTLiuu05yRhZkSFlGCxQq7rw9RFu4ar/cZoHB4+VpLyd+YXDBAEf3hfjTmj1U3RMsBs7VH7QhhzPsm+VpDSvqIc7JHXrWft386DvxjQycScXWad2mBmflmSuMcuY6GPM9HJygsMDAoieYuKDE8opV+cKZYqrQOOmehLFQhV3F7Z3UxdlqhKfcp9BTdJbDug9BMdofXlbhvDnkkeuRXYt3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZxvxdeHAEPrzDdSDYZNdg+Nj+o96vXi3nFp1R79ftg=;
 b=x6Dnw0IvYclc5eF8uCNzlHqB+4FWuXqPeZzqJ93/Az0nfdlsCZoO+/QEUa9klV9ckbJX6xX5WEccBCCSHCZasT0peVRNCHmTPhGaCUPGrA5py724a2rUh6TmzrwA/eOjnF0FTc2okzG9GnEV91YR+guBmLIlXDaxnir4LMSxbfCMZRDa528mSoa3dGlZd+IWya/Q9OuYAwDAgAgbHIJuIINtZ4YHxEvGNKbqeIAMtZmJBB8C28Y1wi/MjZKcyR7inRMa8TQiqIvzvHx/NmpAy1oG98iR8YYWDVTWH9cjnUSKaoxIiRkFob0WrfUwS8kJ71Ia8EAvjvF4ra+NjMkTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=flourishdata.xyz; dmarc=pass action=none
 header.from=flourishdata.xyz; dkim=pass header.d=flourishdata.xyz; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=flourishdata.xyz;
Received: from MA0P287MB0745.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c7::7) by
 PNZP287MB4432.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:283::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.21; Thu, 26 Jun 2025 20:47:13 +0000
Received: from MA0P287MB0745.INDP287.PROD.OUTLOOK.COM
 ([fe80::7f77:5a0e:f7e:c8f0]) by MA0P287MB0745.INDP287.PROD.OUTLOOK.COM
 ([fe80::7f77:5a0e:f7e:c8f0%5]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 20:47:13 +0000
Content-Type: multipart/mixed; boundary="===============8676818521704779776=="
From: Min-Jae Choi <min-jae.choi@flourishdata.xyz>
To: linux-erofs@lists.ozlabs.org
Subject: LIBRAMONT - Agriculture/Forestry 2025
Date: Thu, 26 Jun 2025 20:47:13 +0000
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To MA0P287MB0745.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:c7::7)
Message-ID:
 <MA0P287MB07450486A9BA40DE9573F0F9A57AA@MA0P287MB0745.INDP287.PROD.OUTLOOK.COM>
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
X-MS-TrafficTypeDiagnostic: MA0P287MB0745:EE_|PNZP287MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: ea130fc6-32c3-433b-fd36-08ddb4f2a13e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|366016|586017|376014|4022899009|8096899003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDdQRUFKdEJlOEIxTG11Uk9FYlFLODZ5REN0YS9ycTdvYTVjLzRaT3lGTk1F?=
 =?utf-8?B?VUxwU3FNd0ZyckpzbnJaeGFrSmhrNFFrWkZzc1g1WE8xUE13bjhsVHlZSkNy?=
 =?utf-8?B?UzQ1Y2JPMVVZY0p2b293QVNzaVBuQVR2MTRSNHA4QUxjTHlUeXRzcC9nRXd3?=
 =?utf-8?B?N3I2L3RFaHhLTnNzbkZzWDVQUVpkbXA3UzdHWmE0cnlLVnp3anRKQy9VTGRC?=
 =?utf-8?B?bkZzMEV1cWtmRjYrNlVySHF6LytnMWJYbTFyai9RNStNY2NXN2lLK2NyTlZt?=
 =?utf-8?B?dUhoVGh4eGJlWGptQ29FcVhpSyt0bTBMVHcvRFJKcXRDaGdkWFdjQmZkVjdn?=
 =?utf-8?B?M2ZieVZ4ODdNTHI3WGpqNDBKb2RwY0cwdTArNEJudmgyWnJLM3puVWY0cmVO?=
 =?utf-8?B?NURId2xzVlVUd2pYR0h6RTM5dTEwL3BTUy9DdUtkYXgvd25LNlJvbDhjejhl?=
 =?utf-8?B?aFg0RWczY3pNUEMzdVlEdk8rUDVDRE5oaFkvYjZoY1dzVFpzVlQrQ2JING1T?=
 =?utf-8?B?Ym8rQkFIQmFCbmtvL0llUE0yS0xJbjNiK3NqZGpOM3lxbTlZZlJCeDM3ZG5H?=
 =?utf-8?B?cGJGZnF5aWIwOWZYUDR0V0RMdGJSL01LVHBQTkc3SlNGOXd6WVNpdXF1MWd5?=
 =?utf-8?B?MTFCTHErSW82VmppSTR5T0ZMOWJlTHBSNzRBQk15d08xd3cxb3JDWnloL084?=
 =?utf-8?B?Zlk4T3U1dStpMlRtdjgwdlpRbGtQV3NMY1grTEFJV2hNM0RJWWp0TmNxOWN0?=
 =?utf-8?B?U0lJTGxLQXJDUHVtOExxeHJUOWtmcUtJKyswUE96SlBoZEc0eWNPNVhla0th?=
 =?utf-8?B?WU1Xd0RFR0Vuc0VrVVpSTDFnazRwcExhVW5WVHd4dEo5Z25ObERtV2NlVW5M?=
 =?utf-8?B?ampZazQwRDAzVmpTYXBWc2xQWkxKZG1rMWExV01FblBCMW8veTgwTFg4eTZm?=
 =?utf-8?B?UVlkY0picFF2RnlwSmk4VUJMWWRDMXRYbGxwbjhvZ2tzQ1Y3M0NwYllvK0d1?=
 =?utf-8?B?d2x3VFd0L2QraUxvU21sZE9YS0VkMHJuRmMwaVVjRkNRalBwL0lMR1RsREMr?=
 =?utf-8?B?N1dtVmFYVnBVd292YklXc0FDYVVxSmFaZFovUWlSYnBNODZ1TFNvcURYdlhx?=
 =?utf-8?B?NkFmbTdFNGV4NDJMOW1BZmVKWXNlaU1KbjZpWTkvWXJnSzVLMzZlTE9pU3Yv?=
 =?utf-8?B?dnVzY3JydDkwMVVmeFpLcVFEenRZSWxrcnJ6czhjRlpqRDhzSmpsUEkza3pp?=
 =?utf-8?B?Rmh5YndYTEU1Q0hZNHhvVDFCODVobm1WUjlQY2wrY2F0RFY4ZEorMng0dkg1?=
 =?utf-8?B?dUJHWTMxZVZpS1BwSU9xVElFd3A0elVQcE9pQml5clFqRm1LSzNyT2VldlFO?=
 =?utf-8?B?R0c2UmFGTUtDQnRPOE1HVW9JMkVTUktOdEhmdDVRVCsxUnRLa3ZzUkZraEZh?=
 =?utf-8?B?WlEwVnplT0VTWndWRWJ3M2ZJZjBEUm1lcEEzcURQR0pkZXB2UXF2YnRiWkRh?=
 =?utf-8?B?RUo3ZXhoZWNmRDZkNHNlemF2R09FcWNoNGdHVmJvRGRGS2pMTUhYai9KbmVl?=
 =?utf-8?B?bTFtMTVsYW5YaE9Ec244MXlzN0xaRzJUUFU3cmx1ait5ZjhvdzNVQnpYYjUv?=
 =?utf-8?B?dzMyaUNwdUhMWjFwTVU1VjQxZVkyU3dsdXN5NUlyRGRSSXQzL0FTcnFxTVJj?=
 =?utf-8?B?ODFUTWoyZGo3YzE1cjVjQk9pOHQ4YVQ1WnNZZm4xZUs3M1QxSXQzaVllUGZk?=
 =?utf-8?B?RkZJUk1SSHg5bzN4NHVFNzlyWGRpWGQ4NTI1U0ZxNVBuV1BhMWxRdjNhVmps?=
 =?utf-8?B?WlhwTXhOdGxjaFdNcG1LaXZ2em9teFVNZS90QmI2blo3d0hPY3U2bTVNcVMx?=
 =?utf-8?B?OUc3R1M5WVdxd2IyYnFYLzNxSHdOZlYyS3ExT1QyWnlzbXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB0745.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(366016)(586017)(376014)(4022899009)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZllnclVFRGJFMXgrbEk4MGVrbU9TOEVqRjRMWWozcHJFQTZFT2wwM1l0Wkxy?=
 =?utf-8?B?dmpLTjh3YWJaYVBkUktYT09kZy9Hd3BLMktObkxSSGI1UXU3eGExcDVFRVlv?=
 =?utf-8?B?ZFBSNG1OVEUvUCs5TnRXTzNGcFRKNWd3UkxRK2REamFYOTlpM0RQQkVZRm5U?=
 =?utf-8?B?R04yditpc3JuUTdTbThVTzBPMHBybW9JVFlySzlKL1FSZXdWOTBpVm83RnRO?=
 =?utf-8?B?ZkIxaEI1Q25ET1ZBeXBIck96bWZPTHc4NElReUtoRHV3MzU5TFlmWnUrVm1S?=
 =?utf-8?B?ZnZrcFZoRHh5VXlIQmlvdk1ScWJjejdCZWJlbmZ4ZVpwcWtQRTBTOVY4R2cv?=
 =?utf-8?B?TDBOSkFmSmhjSjFRa243SUZMMUJxc3JqaTRKVnREZVUyOW5STEU4aFFNdHl2?=
 =?utf-8?B?ajdPUUk2bmkrK2Y5WXdOWitJY1BSN3VrMGRKdVhBRWRPZjhIem1yRWRnU0th?=
 =?utf-8?B?N0UrczBmV25aOXVjdUVKQVhBUHhHN1JXSzNiWjVMN3F1YkhCT00xZHhoaGtm?=
 =?utf-8?B?NWdzTTZTVU0rNTh5RDliMjhaUDJ2MExvTHd4c0tqM3ZFdUcrazBlT1hxRUZo?=
 =?utf-8?B?a3RvMW5VL25UT2pUQW8zWjF4VTNXUGhjWEpZd2pPNVh3SjlOb05obmZ4UHJ2?=
 =?utf-8?B?UkovRmxTemxYeWZSZEsrSmNnbEIzTW40R1Erakgwd0JTVlp2L3FVLzhrMU1D?=
 =?utf-8?B?dy9FNW5xUEx6K0xwMU9IZEQzWnB1a0xyOHNRSFErOExFbXhUa3VoTmNqVjJV?=
 =?utf-8?B?U3dka1dCTG1IRGwya3J4YVREemJXdEJGcWM0eVZ0NVVTSVk4WCtXWUZwdWlW?=
 =?utf-8?B?ajJ4RzdkSlVCdXBBZFRsbEdHYzZCL1ZKWVpLd093d2tuRlBSa2lrd0c2QjQy?=
 =?utf-8?B?V0gxZE16dk5GWnhSQzRzVW92TmZjV2dNUHhYYWovRC9xckcyN1B3THNWOG5o?=
 =?utf-8?B?U0tYYVZxM1dsNXI2YmlwbDdLd2U2THFNUkZ4Y2RTcG41a2pEYVpPaS9jR0wz?=
 =?utf-8?B?YVdQcE02b0t5U2xWczcvdjJLOUNOZTBWanhJMkRIdzJFdUNrL0lkSkdXR05O?=
 =?utf-8?B?SStpQVRLUWNwR0djV2x4UVIyZ25Ha2RZcG5iYS9zckI3OEVESEd5cDJSN2JQ?=
 =?utf-8?B?QWhubGpvaS9VZXBQamcwckt6aFBlZFQzeENkVjFxeDRwT2tNemk0Q0pIbjhs?=
 =?utf-8?B?akVxYXhrYzNYN1o1YUVyblF5KzZqZEM2YjRwWGpGNzJMT01oV2lHeFJPN2xE?=
 =?utf-8?B?QWd5WmZVUDc5VVY0cE9IbmZ3K2dRSlVTZmxZaGJ4dEtEMEJEMWYxK3R3Zm45?=
 =?utf-8?B?dUpoL1JIQ2tFVjI1ZktvYld4QWVPT09MZHorcjZDdCt3bUpqNkFyOW5ZdSt4?=
 =?utf-8?B?ZEtUNXpPYitzNndleHhlWDhDT1VndTVjcTFNNURjU09VeGFEUHFxK2NVejc3?=
 =?utf-8?B?QUl2aFpSWGNOamphaUg5bFdJWXJZeTdhaEZ6dmtRU0Y3QVYrSUZQRnNWV3g5?=
 =?utf-8?B?Vys2dlZZcjdkc2FVWG9TMXpKMjZaOGZhbnBMVGVCOFFPYWd0SXlCbWtMM0du?=
 =?utf-8?B?d0Frbnd5cFdtSG5UZlJodkdvTER6eDRqdTcwcCtuazd1TzdLemZsV25lZGR2?=
 =?utf-8?B?SEpLdTlTaEhNc2ViY1pVSkRBYW5zL3U0aVFwYnJXVUJGYkxnaTJNdENGTXR1?=
 =?utf-8?B?Unc4Q0pROTJ5dFNFSDYrOTVsUEdCRFNQVjB1R1FYZnh6cXpKcEEwSWN6d1kx?=
 =?utf-8?B?MDZTbm15NGdpYTFGRkZTQnFNSGFEZStPQ2FaRUdyZTR1RE11QjJVUXBzSmJG?=
 =?utf-8?B?VUhlZVE1TERXSnVVbDl6N0pDQ3NCNlJuQ0VnTmVjbjFIaHRVb3VQdThzcjRm?=
 =?utf-8?B?RDUyWklwZ3IvRnFEanJkeTFmckVSZWJjSU5laE4yL20rcTR2UGJ0ZGc1OXZD?=
 =?utf-8?B?RzhOYjVNRllJVWxZZUdLQTIvQTBUNFVvc3ZNNmpLTndyQXpjZHl6eHRyQWtD?=
 =?utf-8?B?YjEyOU9JMFlhV0Zvd3hBRkpkZWQ4QUpyZERvblNmK3dZOVFjRVVNRzVtaklO?=
 =?utf-8?B?OHV2NitMdllaRjR6Nmt0djV3S255NHpzWjdReVVHdFlZSitqQkVnYzJyVWM2?=
 =?utf-8?B?WTJoZmF2MzBkS0VNOUlHY09RZ1Q1QmRjNmpFLzVUcVlSMzgyTVljQ0hFTlVK?=
 =?utf-8?Q?e7suyPEaLdGG49TSRFu9JQ6gOpddsS/HsoMTs6JrGUhg?=
X-OriginatorOrg: flourishdata.xyz
X-MS-Exchange-CrossTenant-Network-Message-Id: ea130fc6-32c3-433b-fd36-08ddb4f2a13e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0745.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 20:47:13.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67dd4a38-d942-4abc-95aa-6bc92a44f6a2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOax8KD+3leQzWtgelQJ+tOjWwynkAKuvsSM/cuJzS5dHjpuAL8XwcsiFlQ6TT8MAWgvpK/YbY0yx6KrM3OCo9HAcnAuC1T2Rl0XX9hI3mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZP287MB4432
X-Spam-Flag: YES
X-Spam-Status: Yes, score=4.0 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	FILL_THIS_FORM,FROM_FMBLA_NEWDOM28,FROM_SUSPICIOUS_NTLD,
	FROM_SUSPICIOUS_NTLD_FP,HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,
	MIME_HTML_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
	T_FILL_THIS_FORM_LONG autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 ARC_SIGNED Message has a ARC signature
	*  0.0 ARC_VALID Message has a valid ARC signature
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.5 FROM_SUSPICIOUS_NTLD From abused NTLD
	*  2.0 FROM_SUSPICIOUS_NTLD_FP From abused NTLD
	*  0.6 HTML_MIME_NO_HTML_TAG HTML-only message, but there is no HTML tag
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2a01:111:f403:c409:0:0:0:2 listed in]
	[list.dnswl.org]
	*  0.0 FILL_THIS_FORM Fill in a form with personal information
	*  0.8 FROM_FMBLA_NEWDOM28 From domain was registered in last 14-28 days
	*  0.0 T_FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--===============8676818521704779776==
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJz
ZXQ9dXRmLTgiPkhlbGxvLDxicj48YnI+V2XigJlyZSBvZmZlcmluZyBhY2Nlc3MgdG8gdGhlIEF0
dGVuZGVlIGxpc3QsIFBhcnRpY2lwYW50IGRpcmVjdG9yeSB3aXRoIERlY2lzaW9uLW1ha2VyIEpv
YiB0aXRsZXMgZnJvbSBMSUJSQU1PTlQgLSBBZ3JpY3VsdHVyZS9Gb3Jlc3RyeSAyMDI1LiBJZiB0
aGlzIGFsaWducyB3aXRoIHlvdXIgY3VycmVudCBnb2FscywgZmVlbCBmcmVlIHRvIHJlYWNoIG91
dCwgYW5kIEnigJlsbCBzaGFyZSBtb3JlIGRldGFpbHMsIGluY2x1ZGluZyBhdmFpbGFiaWxpdHks
IHByaWNpbmcsIGFuZCBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLjxicj48YnI+RWFjaCBDb250YWN0
IEluY2x1ZGVzOiBCdXNpbmVzcyBOYW1lLCBDb250YWN0IE5hbWUsIEpvYiBUaXRsZSwgRW1haWwg
QWRkcmVzcywgUGhvbmUgTnVtYmVyLCBXZWIgQWRkcmVzcywgTWFpbGluZyBBZGRyZXNzL1BoeXNp
Y2FsIEFkZHJlc3MsIENvdW50cnksIENpdHksIFN0YXRlIGFuZCBaaXAgQ29kZS48YnI+PGJyPkJl
c3QgUmVnYXJkcyw8YnI+TWluLUphZSBDaG9pPGJyPlVuc3Vic2NyaWJlIHwgUmVjb25maXJtLjxi
cj4=

--===============8676818521704779776==--

