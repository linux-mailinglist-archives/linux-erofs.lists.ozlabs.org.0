Return-Path: <linux-erofs+bounces-3571-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ugbRCclKK2qx5wMAu9opvQ
	(envelope-from <linux-erofs+bounces-3571-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 01:54:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3603A675DBC
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 01:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bZuNjILP;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3571-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3571-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbzyn2FQ6z2ykX;
	Fri, 12 Jun 2026 09:54:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781222081;
	cv=pass; b=mPazk1wOypf1E3dMtXoBKqGg//qaNREqShnR2W8kQRMe+8/S9WlJBuWuKCL/awSbN5fTS5/INUTbENCBvJN+5wmRmingp5fcVlGHoQn5newTpKXpRiAdAy8BwDR38MIpa8PaEH4GAW8kL2AVZVXL8/P/ceMU1Iq0hSN48KX0O+3T2dEKHFO0WGaXDCnQucMlWP1l1HsFm1KyY7T4OyUQRiRdyDEzVYIPRylcPmCn+FUxh5SmLpiH7QkH9K2h1/IASq1cT6G4ggEuZxNcdRc63QBGg8wNCtkFs4+ZbBmK0tUdVh9u8xIX7lR0gY429HcDmdl0SEPhwJaVIH/lPhrcNA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781222081; c=relaxed/relaxed;
	bh=yj4F/kA8SRRkhPGgm3PfLwxXH9xOKjrffijc/iuDtmE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=GGZJcxJlPAKXAJFhKasxz4BGGhB/6gUXy0v5hYPymt8MThLp1z2BOWHxfNA/FOBrwTDqho2bRe7eCQJaz2WchFk5MMXBcaS+iyLjZKndB9KTgrC9OujABPKVB9d6rBiuelZxFA4rZ2/XGJeG0r2k7xHTlBX1ar63KFkuLA9WeDFS/IuwaewP62DfD6Bd8jtlAmuCmL5ECOhyBuc/CAmzJKMjzSwrmz6MsjS47fm6OBUWehy82/Ddt/SlBxp1lmdUEn/BE7192q8lXzdobZhWbm0HXsDAlFkR4zbobOmhqdGTLRhzLnLRRM7mf1md1O3mBC/bcL1z/78E+X7wDXMkKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bZuNjILP; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jcalmels@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbzyk3GYRz2xl6
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 09:54:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1NU/Mdpt4F7NgxJyMwTHsdH+VHQa0wZ7qbEDGw5jUcU3epioA49UgHeToTaHjo3EJ4pRb9qIp2U1wUo/N767oyJW5nGWcxh26alQRHSM+Z+lAVLSXX2qL1AXLuSHcZbTT1Ykccy8TneBhMKjhiWHGJDCyrijyJw3dvkQAN9WfbydPkGqjavJHI+1rOal9CQ2E1huq0NCAF3QR/K7qvKwXUJSoxtinOfY/SmPwR4GR9jf4LpvSccTLzR0QEJVvnFZJWiKrDiy1Y6S7oKtRNAiYf38LGai2kd2i3Pdwu5QQPTeRV+iFkFqC+KZzuxVqWrEpBseRkaVF88n+GddDjjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj4F/kA8SRRkhPGgm3PfLwxXH9xOKjrffijc/iuDtmE=;
 b=qbMpwXxgBbd+OV4r8gnwrsKaBRR7on63sZDR/2lHhmy6LcCSihfeVgwTQ9u0bEG7l8PLLTYrSYJSXbDriTG3gAB273DH9UhTaziTO36zK3V9F12K5DtBNIFuO1afJCI1WMGB2Zr1j72beC5eV1oIKRCOOQsi1FY/NFl3gQfhiME4Dov76Dmhq/2Y4fD/3fe/8TB/wQ52YkZ8FVs04FaoA9BEBeo4qUJwy3EqIwIFPKr84oV4u3uWbn7e+1Ld3biJBwly3mkhH3N970jdRXdm43telCVC7m7Q2LJ4b8uM2x0DLz3Rl8shZJP/2/Jc8uTLNhAGRNFhy+pnTf5xZ1JJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj4F/kA8SRRkhPGgm3PfLwxXH9xOKjrffijc/iuDtmE=;
 b=bZuNjILP5ylhMit9I+riNV1UoXaTlQGizigixHMbBksIotzm/iMVNPGncDJAcSIsLtnrwQSXgIwXggonngvs05YAA0jy+7YwwSXyrvL+sFFNmWGdKPVsGCpcqxFRu9sYwkUFwA78pIAtyTYlXOVQUJdwKlne/fjM7SjHwvam/io0GG21yetI7VRkQ8AVO59RpJXG9MweFtUJJdFCCAHIzc61iUG5ybHfy+aahZKhr9icWZeOfzDaP/CNTL2FqqclEP1HHs2t0YwxT/7vur11zeNeJCnKGKnz6PDN1oneX2z8UmM6uvzTvTMswFKyYee8CfJdghV+/9lFUXuhdOdung==
Received: from CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 23:54:08 +0000
Received: from CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f]) by CH2PR12MB4969.namprd12.prod.outlook.com
 ([fe80::8317:5a85:3569:fc0f%6]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 23:54:08 +0000
Date: Thu, 11 Jun 2026 16:54:06 -0700
From: Jonathan Calmels <jcalmels@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <xiang@kernel.org>, Jonathan Calmels <jcalmels@nvidia.com>
Subject: [PATCH] erofs-utils: lib: fix null deref on incremental uncompressed
 builds
Message-ID: <20260611235404.1620899-1-jcalmels@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR12MB4969.namprd12.prod.outlook.com
 (2603:10b6:610:68::8)
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
X-MS-TrafficTypeDiagnostic: CH2PR12MB4969:EE_|SA1PR12MB9545:EE_
X-MS-Office365-Filtering-Correlation-Id: 73934898-a5af-4010-b01a-08dec814ba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	16FdPVBJFs4wlucZjK0FDPmC1b9ozaxjuJwATTmGUUgNRVy2xtw1KlKyhbR0Vz1enpcjjZSto0t0xWqz3XbZ6PgTOeuq2nn9ujyu3o1ZczaKV+O1JRfLKwpTYThiiQYJLWrYfwmSHlzoPWlL99/INZGXNmrMEAuakOkjhMCD10J7MDbKFBWbwORcCFKv75cF6M8mI3g1FaUXU+AGqdT/NgDX/LYVsFO2tONFezxELniQwnMaZ6ko0pNgvAN9pRGwuvOLx1sL+QqhOheS+FJ5/iZRyEn22Ce0YXsQhGPR6U/IZRAwwQ5zFmSaxY8igY6caQgxg4yhLWPEsnTGs1LGTsBa/H5P/9VY2FnZtyYQ1MaAcTm7GxdCnryvyouob7ZExKGPfSJeAFLy3hZKPAYBslMjLQu8oFX8Ic4XWwLHWFMTGMpC3hHwjpA8omXg2IF+JM4FpFQCRok2qL8/CZZRlLYT3yLMl8VXxpmuEzwNosI/SRBca8inkJZ4n49UEoheq3Imf4CT+9w+yoAFQ+fzyVqcZKGA7DnxLkKzi9UaptKkImQzdbbWBH+FV9YZimVJKd4DJj1yPrqHdj5AwEIUdD05Y6hy0GaMY/T/PNOnDXIbjbNqjeMrpu5B9j2MRz5zDwxXuERwC0+hbc5NbJU/ASDRbyIghZw650IxoYonc1iTqIXiKTxOoljQpgREKrOg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4969.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDU0d3NPd2pUcEVCT3puNXlRbWNXNU9JdUJyMjF0QlN2ZEZMTGdGNHhFNkln?=
 =?utf-8?B?YlUxWFREQW9PS29FRXdQck5VRmF3TmVpZ05JQmZzZGw3elpqcndDU3ZpMVNj?=
 =?utf-8?B?cW9QTVAzL1RUeDgzVjM3RVRvK3RpZFA3L3pyU0haRHBEU2c1L2RPRE1HUTBy?=
 =?utf-8?B?SHE0M2lmTmhiZytoNjlsem1IWEt3bnZDUXZaNmV3YWpLTXpRdGIrdjExNXhL?=
 =?utf-8?B?MnE4SlVuMm1kK1c1L0ozS0VnV1ZCbXJ1emNEd0R4RmVnUElrL2swcHdPb01a?=
 =?utf-8?B?Zkh1bzN1bnVPR2VTSW9rMHFGMURHVS81dUFvRDNYK243STZ3K2Q2aHNrdEFa?=
 =?utf-8?B?WGtoR1QySjhUNVVBOHluRHBITmdETDIweVVnci9yR0lRSmk2UzR1b2RXRmxk?=
 =?utf-8?B?K09QeTBrMkdURFdVSUNiMDNQdG5Ca21IcE5IQ1d5aW9VbFBmSGl1ZWtuTzlT?=
 =?utf-8?B?dllQT3c2TGRIcDRHdVkxRWRtdTdRSXYwckJ0UjRiK3NRL2tlMmlmVGtPcTh1?=
 =?utf-8?B?bndyRGtyNDlKaGVsa0JFa0pYU2FJcitib3JhVFI0MURPVml6U1R5VDVQRWU3?=
 =?utf-8?B?a05XSHF6TCs4bnpBUDF3UjlLN2dUUVc4WGl1SG1HN2U0K2Z4WFMydXNiUVE1?=
 =?utf-8?B?S2t5VlRRdzlaL1hZWHRMVHVCUEwwKzJLNVBabXBtV3VOWHVmTVJxV2wxby94?=
 =?utf-8?B?cVIvZkxmTHRYZnV1VE1CRnNSNmZzUlZPNmJHZzlGc0NjZTJSSzR5YTBEMUZ4?=
 =?utf-8?B?aVM5RXFtV2MzR1VRQ3lZN1FZVTNkaFFwWDd4cnVwZUdEN1dzS1IxVU5mYzdt?=
 =?utf-8?B?UWR1M0s5RjRZSlhrSjk1QTlwWXFsck5lci9hdGxwTS85aCt1eUc3NUs0WHlH?=
 =?utf-8?B?YzdZSmF0VUh4WlkxUXhYVk92MW1tWk9WRUFVdUh5Zzc5Nlp4TjhPZTg3SStQ?=
 =?utf-8?B?emZGVXRCdFNYSmQ3UVFwK1BBR25FSzlGampMTmNIMUhNbGJVK29xdTRpY0Ns?=
 =?utf-8?B?Y081RjlMVjcweDg1bHJwbGNjMjZlL1RXSElVNTVHRHExOFI0VkxoSCtSY1I2?=
 =?utf-8?B?WExlckFRM09aM0ZHVUZrTEUxdWg5aEtKczBhdjB3bHY3VUMraUtlMmRNWnZQ?=
 =?utf-8?B?Qk16OEJzU0pySmZuSGtYNnl4b1MrazhtVVdFMVMxRkRUUEpmcWhmNnVoeTZt?=
 =?utf-8?B?UFdFSmpPSGJtZTQ0OE1Dd3lZQ2hCWTFCNnU2QnFxSWIwV0NDc0xNUE9WTGdU?=
 =?utf-8?B?VndZdHpTaFBOVFA4TFZNZXBDNDBGeFNucy9rWC95WTVjbjFLU21lbkxCMlMw?=
 =?utf-8?B?cVVmSUtlWEprOVdMM2NsbHIvcWF5YUdvUXdNbmx0eEtRMm13UHVkRlZXVVJz?=
 =?utf-8?B?WjlyRE0xTllScHNXSXJBWlg2dWtKMUpzNU5MZVFvdytXd3NBZjZaeHRPNW52?=
 =?utf-8?B?N01zTXdKM1ZjTS9OSVI5MW51YnlOdkRIYndjWVJ0UXgrSEdFUFd4QmN2WUtG?=
 =?utf-8?B?QUN3WFFQNlVoYU9XOWxPRU9tV0hNdnBNWnBoamFqYURtUk56eE5wbVA2OEtp?=
 =?utf-8?B?d3FGbWQwb0xsempNR0djTmNyZlFleGpQNXp2MnI2QjNocnB2Ui84WVk4WFZ1?=
 =?utf-8?B?WXRvcytGeExQSlVtSnppc2lUQVRpTjk2SmZQRkdlYkhIdXFzSHVjSjNUb0hK?=
 =?utf-8?B?ODdUc2ovYzJYd3hIY0c4empLTG0zVGVveGRONHArNDhlSkRRcmw5dTlJdG9X?=
 =?utf-8?B?eVlHZWI4ZElZTnJ5YS9QOWZjOTh3UFRScElzZ29TWTUvUjQ2RUpZUmVHWGhO?=
 =?utf-8?B?YWZwRktSeDUyb0szQlRHSnZaejBic0l3emQ2V2p0dEhTUzJjYXNIY1Vpc0lR?=
 =?utf-8?B?YnlGaTNYVjVtQzhWWkhKcFZBTU5YK1lLRWRzYTQ2M3IwaTZsVmtZazFjNE50?=
 =?utf-8?B?MGkzZi9ReVpXQ0ZrMnJlR2VBZGlOanZkSzFNSjNwYVVYUHI2Lzc0RXVhVFlx?=
 =?utf-8?B?akl0QnVRZTVwcXFZcGV1LzUzRWUzQTBZdkhUU1gyNjZZTlFVb0dvTWJlb0FI?=
 =?utf-8?B?RGhUdW5FanBqTGZLUDRLcE5oSHVHWFl6T3V3S2J2NU1ubE9veHRvZWF6cjAz?=
 =?utf-8?B?emg3UnFpT29UU2ZvMEVtTWVnTGZIOUlNRkdBOVhka0U2M2FSRlJTWlFuMUhz?=
 =?utf-8?B?MmM1L0FHVWl1ekhVVTBsQzFJK0VuOWlpc3ozSE9SSFNXTzhnNEJIWHBJc0Zs?=
 =?utf-8?B?OEo0ODdqd1Z0dVNlRmh2cEIwbmNpeG9FM1hIUm50S2p0VHJrTGQvdmxmYStK?=
 =?utf-8?B?bXVieEVRWkh6dC9NNmhvQ3ZNNkIrb3kxbWdFSGtVN0VDVVZmZUtRQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73934898-a5af-4010-b01a-08dec814ba4e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 23:54:08.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSkqK7rTn2RKdhmdZ/Ae/wDdlKU9HM3DThmc5cc2Wjlk6xKOkdRo28s9dnYAyFUmUI6XxHgWUdIXMPM+oilX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3571-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[jcalmels@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3603A675DBC

On incremental uncompressed builds, z_erofs_parse_cfgs takes the legacy path for
images without COMPR_CFGS and unconditionally sets available_compr_algs
to LZ4, regardless of whether compression was actually used.
When the current build requests no compression, z_erofs_compress_init
returns early leaving ccfg uninitialized and available_compr_algs
unchanged, subsquently causing a crash when alg is dereferenced.

Fix this by gating compression on whether the per-algorithm ccfg entry was
actually initialized rather than trusting the superblock bitmask.

Simple repro with alpine rootfs:

./mkfs.erofs /tmp/alpine.erofs /tmp/alpine
./mkfs.erofs --incremental=data /tmp/alpine.erofs /tmp/alpine

mkfs.erofs 1.9-g1d5bacbb
<W> erofs: EXPERIMENTAL incremental build in use. Use at your own risk!
Processing bin/sh ...zsh: segmentation fault (core dumped)  ./mkfs.erofs --incremental=data /tmp/alpine.erofs /tmp/alpine

Signed-off-by: Jonathan Calmels <jcalmels@nvidia.com>
---
 lib/compress.c          | 10 ++++++++++
 lib/inode.c             | 17 ++++++++++++-----
 lib/liberofs_compress.h |  1 +
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index ea07409..e5bb784 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2186,6 +2186,16 @@ static int z_erofs_build_compr_cfgs(struct erofs_importer *im,
 	return ret;
 }
 
+bool z_erofs_compress_alg_enabled(const struct erofs_importer *im, u8 algid)
+{
+	struct erofs_sb_info *sbi = im->sbi;
+
+	if (!sbi->available_compr_algs || !sbi->zmgr || algid >= EROFS_MAX_COMPR_CFGS)
+		return false;
+
+	return sbi->zmgr->ccfg[algid].enable;
+}
+
 int z_erofs_compress_init(struct erofs_importer *im)
 {
 	const struct erofs_importer_params *params = im->params;
diff --git a/lib/inode.c b/lib/inode.c
index c225faa..05344e7 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -624,9 +624,18 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 static bool erofs_file_is_compressible(struct erofs_importer *im,
 				       struct erofs_inode *inode)
 {
-	if (erofs_is_metabox_inode(inode) &&
-	    !im->params->pclusterblks_metabox)
+	u8 algid;
+
+	if (erofs_is_metabox_inode(inode)) {
+		if (!im->params->pclusterblks_metabox)
+			return false;
+		algid = cfg.c_mkfs_metabox_algid;
+	} else {
+		algid = inode->z_algorithmtype[0];
+	}
+	if (!z_erofs_compress_alg_enabled(im, algid))
 		return false;
+
 	if (cfg.c_compress_hints_file)
 		return z_erofs_apply_compress_hints(im, inode);
 	return true;
@@ -2049,7 +2058,6 @@ static int erofs_mkfs_begin_nondirectory(const struct erofs_mkfs_btctx *btctx,
 			return ret;
 
 		if (inode->datasource != EROFS_INODE_DATA_SOURCE_REBUILD_BLOB &&
-		    inode->sbi->available_compr_algs &&
 		    erofs_file_is_compressible(im, inode)) {
 			ctx.ictx = erofs_prepare_compressed_file(im, inode);
 			if (IS_ERR(ctx.ictx))
@@ -2378,8 +2386,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		return ERR_PTR(ret);
 	}
 
-	if (sbi->available_compr_algs &&
-	    erofs_file_is_compressible(im, inode)) {
+	if (erofs_file_is_compressible(im, inode)) {
 		ictx = erofs_prepare_compressed_file(im, inode);
 		if (IS_ERR(ictx))
 			return ERR_CAST(ictx);
diff --git a/lib/liberofs_compress.h b/lib/liberofs_compress.h
index da6eb1a..32e8e03 100644
--- a/lib/liberofs_compress.h
+++ b/lib/liberofs_compress.h
@@ -14,6 +14,7 @@
 
 struct z_erofs_compress_ictx;
 
+bool z_erofs_compress_alg_enabled(const struct erofs_importer *im, u8 algid);
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
 void *erofs_prepare_compressed_file(struct erofs_importer *im,
 				    struct erofs_inode *inode);
-- 
2.53.0


