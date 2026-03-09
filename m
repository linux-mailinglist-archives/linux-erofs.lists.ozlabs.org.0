Return-Path: <linux-erofs+bounces-2551-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK0RI8z3rmnZKgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2551-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E323CDE2
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV2m873Gxz3cBd;
	Tue, 10 Mar 2026 03:39:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773074376;
	cv=pass; b=PZTsjcrs7gV+O9WXfytMZ4ZkJGQELspcpcEg0KFT6hPfQ6bx0Jiz1LdtbZUO7mixo5WxkPw3U9t+kdSAN9czaqRCh6tu2RGJEjkpzxmL9JJjjF9pfNkHPsMwYArO9MvUheU2+huLMwxbhwAWr5C2geHaQOujAG106CbXDgp82aTe1c7JTWvcOK5SOo2gZQa1n0YAOhVS2OD6fkA4Db2XQOIZB254qGxzVWyNJz+JvwFsIgQuQoTNbHd9HzpgnZ/7dO17oDXaYWuhs57Ehwusv2kRFcsiUMngcuOFmZW3gCSE/Pnf8uuUmogrq93UIh5kC6YHFHVMxV+tQgcBJIMNaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773074376; c=relaxed/relaxed;
	bh=9YURd6O0VaUkOMjb/TxJV6ss3E3JYPexRBej3llZfkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GBbZnM8fyb5WmOoAfNbhAuuEecAid84x4K0fHdVX1wtlkln54wT8IL5hDLCIlx96fYpXQBwkhTsiFIHmvZHWizzhzM3+dsEJOF5k3ske59ouIIyCWzTBz2z8ZoGZvYcDdzOCOoymV8PQevWAYXnabEydiOE1h/VvrH4H17yLBDziekZXhyxhgfbEno93NmAUzfs5N+p6WPxcbu+N4a1T9E3cYegB7tN/NnXaWx/xAEC63Hs697+/oIzEwY742qvqi36G5XFKWVzfPFMpmINhpFtFm4iayTmbdf1lG87yyydizVS2S1F3j/2tlur51bjHl/qgizFGnrheBVo7GnuIlg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H9gMmfAB; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H9gMmfAB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV2m82qR4z3cBb
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 03:39:36 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXbZ5Yk8T3rQkTGzP/j6E4ssIPSQp6nl8l6VS8c39+DQ4jPu16W/sQdkslWeVLCdNNJ0ytbEEi0FrORL6YBqwK4U0cQoXKHDgRwfoA1ec9vj2xHl3UybPWoqiZJtNO7T3+0vl/m3l59+MKXqRInrtfRbSrhulP6svttkYpxL0HkfqJLvE/fMa6rfd9crDWObVg1bnVGr7ucwRsKECBLKG9eaNZa20yZfpwUOig3u01lAa5Iswf0vXzYeytqB04twjAT0mzshn9JwRlKEh/g2p71znvsp3yKz9nvlFAEJwwIJOV9LRIExZ3f+hxECwYoqNHGwALeA75fPuLejAuXD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YURd6O0VaUkOMjb/TxJV6ss3E3JYPexRBej3llZfkM=;
 b=t2p14n4LoeLu+S9mo10zw9eLDuXDMdv5SLsuspKweQKJ3Yx3sdzrDqF8xUPHdIZ0UeZzzcvFTZ0KQPcmRg8pJS2YRCabULtoAg/Rf97Cr5orQHbkx7N1PotnHWzXHqILVirYqMwLMQ//WOJeEz3jJDU+weBSL48rsdws9wDfWYxUvqzoZfAGMR/OzMTvNbAs7vJ7PDpuVtj3+FypDZ1q5HSeuBUbm1bPF6xDk8oHjns+i7xdKFKQ8rQX/oGGdykP+bGhbY1Ywx/pWOD8wjRNP8TQvTzMxG5RkBWeY5rpCxhg8EwIg2pLt9aOGXcs3cYc52yRwY3zrrcUPDTOUOQKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YURd6O0VaUkOMjb/TxJV6ss3E3JYPexRBej3llZfkM=;
 b=H9gMmfABusJdyBok9U9hok4sj3Kq8aFL3SxBCTmAbk9Z494OzHmylgy5ToVm8mVEoIJWKUCLBShr57IPlQ2+xMaT9byY+NkgluAru5yP1x2LQYkDuIxl3UvVE0oKbIN2pzjscBLFDEi51GkjhMpboNbsZAKMWiKYo3lTWuFUjCJhtVYZT+4flcucJRzAEoTJxV/4ukecU5o12DM/PhHgbw+U5xP/OW5AYTXI4wDjVUvXA1639OUFdStnYYyb+bErm9HtEY94k+hgJUG/K0M0IVNYqt5TiwOnT3yhZfcO58SbX0s6r9n/MZR/MnqUq5n9FykVy1Nl8uwPWZSN9eR0uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:38:49 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 16:38:49 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v2 1/5] erofs-utils: lib: pass uniaddr_offset to erofs_rebuild_load_tree
Date: Mon,  9 Mar 2026 12:38:17 -0400
Message-ID: <20260309-merge-fs-v2-1-2dd0ef53db4d@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
References: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To DS0PR12MB8502.namprd12.prod.outlook.com
 (2603:10b6:8:15b::16)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: 882be820-d554-40a8-63dd-08de7dfa542f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	zY8Zcvxss2msHLxFtkNrea8++w273GSLcN69nz8MDyxoz/y51+CMPp1tRt8vunUqJrlJJEctxFpoFas8wksV5376pTt5GlgLdo3fiLpb4gyo67t/o1CE0jeVBureamr9y2MaRvVdz+3mOEKDOlxJWqqP5mmQuocUU6aI/7mGVK4P8D9neLvDGSYHzmAsQzweJK/GZHjkhdE01R4aGEUAQ+r5fQ034cUJBkzuL82DeYHvjf0TPlgp22ZMThBY5xGx6sbd3PNF0X7MrA8cXt5x+n5A1n94XnwD4z/IAlydIcHl1xnwD0MGIFf46Rzo+uAair/fLGHa2/TPIj8FPqQI5oQSQcfbgzLwToRF+TwmX4LAUZUEdTcJz2IUIj6du/YzXO8ZbJweqRL6zSIfjbHpOjc3bDbsFJrAmzHohSjhmfh2ReEoYuHeQjWcg9Wc3K+pi/Kf/+Bu/bZz+NcXeO9KPoKR0m9HTua033vY6dNbeMTgbGaJT9Sljoq8XRZXrdL+8Li9Ka2qpWkuqbcix4T3XA833rWProhafQZa9HFrNsWidJbTaVlwZR4nDDzmr4nsgAdJkwjaSOi+UrXcmN6lZlFwEd9s/3U1FlK/qcKbvSr1QsHssFujQjeOWVB2vs1C5o4mriAHLoFaNv8ChWxYk/lv3VoC0+plujra0Eqq7Hl2/w25VIera9nH5RJYI9NZoXhoMe7NnEEsQQ3pmU1j+h9oInVZPvpig9B6+/bD/Aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3VkaFcrVFFiUzM0bXFLSHFZbmo1U0x2Q1lUNFh4eFpRTnVPNXFTSWIxMCtv?=
 =?utf-8?B?dEIrcytQZjB3aVRjdjhMWjUvYnZwR1BBekhZbDArcDN5NmtlL1JxWkpLcE96?=
 =?utf-8?B?WnNQbWNBRDRrR0ZwTnVSUEsvYkNHS2cxenpXOWszWFFjOWJES0FnRndnV1gv?=
 =?utf-8?B?MFVEMHZ6M1lSL242VXBmc2F0dXU3YmQ2cVFYNkRSS1dsOUI3Y0VxUTFHOERz?=
 =?utf-8?B?cFlZSmVqdVpzOE9XSDRKaVNaWXlYbHBLa3hERXM5ZitxSExscDVKalNHRDEr?=
 =?utf-8?B?YXRZWWVQenJyaWtMYVRienNSVFZBVEZCSHNLVHhreUhtNGhWbEMySkdDWWJl?=
 =?utf-8?B?dXp1MSthUVFKVlpkaXQ3UkYzNk9Pdmd1WUN1SU92WDIrYkZaTS90bmtiVHFP?=
 =?utf-8?B?Tkc0N3VpUWUzSDE5MU80eXpzTjFTaUM2YU9GRlBXQkhWT0NrMTZGdUNEVWdW?=
 =?utf-8?B?d0h3ZXdxWEpXdGd2eXRRbkVDNjNyWnU4VVFzaWIvVi9JYXNaNFJOTlkrVGFR?=
 =?utf-8?B?R3YwdmhDN2xTODh4aXdTQVBFNm1aNE9lRVVLOVFlSE9kOCtURWdYR0Y5YXA4?=
 =?utf-8?B?QVlBUU5IZFFVMnRIQmpPWlp0L0N0Q1JOVlBuRVNQZkQvYW5xb2FNRFFMK2Yv?=
 =?utf-8?B?aEV4ekh0VElWdnFGNGswbC9uMUJDWHlkcm02YXQ5RW5hZXdsMklkSlpBRVow?=
 =?utf-8?B?eWVpb0RrUDN3WWhmWFdibU1PMEZ2RGV5MHBXTUwySkZTcXhxUVlLMnR5NUR3?=
 =?utf-8?B?aHFrbENncUc3ekE1dGR4YWtwaWxJSTExZ28wTmx2VVZOekgvN2VSaU95amdK?=
 =?utf-8?B?YXJ5dzRhc3JJT01vY09lSUY4RWZqUjc3a0FoQUFaaVhvT2FxSkNoZldVTnVi?=
 =?utf-8?B?aGtVVDF0OHEzazYxTkoxbWJaNkxPWWp4dEltL0hoUkJqUTVlNUhYYlJRUXNE?=
 =?utf-8?B?Mzdnc3dZWGJLWnNrM2dhT0o5c3lLZCtGQU1wcVBuV3prWnl3NFdOb2VuNDlw?=
 =?utf-8?B?NjB6cXYzaWY4cnR0Ri9SWHI0WldmMEwxb0ZVa1NQR1B4MVJjNER4b2dRcUxm?=
 =?utf-8?B?MFFtM3NwcDBtY3pqWTROSVc3WndHZWx3MmV5SjlEdzI2RnVnTTVYRksrYVpC?=
 =?utf-8?B?dUJJVzdzbTQwRTloNmdCRzVIcnFrRFBDS0hRclhYRnBjTFA1ZVpsVUpLc3NH?=
 =?utf-8?B?QkZiMmtSd2NQN2NjdGMvdm1nK2E4WkZHR2VIRlBNdnNmbENJTi9BOHowV1NT?=
 =?utf-8?B?dWJUME5OT1cvVWpHdy9aTFJXbXF1djVTK0s4aXEwMmxIai9uaE0wa0lCbkVr?=
 =?utf-8?B?eEYxaEYyYThTOVB2QStGN21CdXpzd050dDlVU0NTK0ZlbXR4ZU9iWkFVSHR6?=
 =?utf-8?B?VlpnRVhVdWhvZmZIcXhiVStYdDNJMDEwZjJhdnFpUlc4NmNvYkFvOCsvNlQ2?=
 =?utf-8?B?RHFLbDRRUFJyVlBoc0FjTGFwaXZ4d1Jja1JXQnVrcGxwb3dmc1E3RzN4aFkw?=
 =?utf-8?B?SCtLeVYwQUlFbTNvYldSN2hEaXQrVjBEZDAxclNQcjYwcFAvYVdJSUJrL2Y3?=
 =?utf-8?B?UU92cWNrQWxMWGhKN3NNd2lnZHpnMTliVWZ3eUdqZEZoNCtjNTFOSkFxQmNN?=
 =?utf-8?B?RU4yck9QUlZtbzRGeFk5akJCWjdIYlZsTktHdFhpMWhhOWwzdFBYaDZHK3Iz?=
 =?utf-8?B?WmtaS3FNQklDajJUd1dIWVl3SXhYem9USkQ5aDF3UlVkb1RBZVRpdDNybjZL?=
 =?utf-8?B?UUk3MnNvZU5POXduSXFNZHQ2VG00MTBVckhzdnhtbHY0ZnBnbUx1ZFZhY2lD?=
 =?utf-8?B?R2luNCtrSkVYTTJxZmtDbFBRSjNWWXNqVW8xMHZNR3dyeUc5YUhSY2VUZGg3?=
 =?utf-8?B?cDBrR1FLaDljRHR6eUxudFdWaTZ2QzZSMUl6ZjN2YnArV204dVU2OVQxMnJm?=
 =?utf-8?B?bFQwMm5UQ2M1K0hqa25ZRS9zRHpCYkIvYWNBTnRjU0E4dU9lV2xwMzc2OVpY?=
 =?utf-8?B?UXFsMXhPUGMxdlZwS3dUVExkZGRQQVl6Mnl3NVMxTE5OYUdFZW9mdGJtVDZ0?=
 =?utf-8?B?b1Z2ZU15ZzVwT3cxREJjTTl2NTliWkg0UnZzaEgrN1Bja3IrSk5QdW9ONHpw?=
 =?utf-8?B?OFdZZ3B1cnBsa0V5SlFEcXRxdkxJNDNPUStFUkZ1V1ZCeGpEMFB4UzVJMStj?=
 =?utf-8?B?d3pKWStOa2JCVTRFUVpZaCtSQThKZnAzbzFYekgvWkpwQmJ0ai9WMjVFekh1?=
 =?utf-8?B?Y0wxdWpPcUZJSmxYanhyMTJicmVmRkgvTE9tZjJkblZPYS9BeVFjOUJpUGJp?=
 =?utf-8?B?Nnhzam5vc2RuengrcWJsd2piVmpPSy82dFNmL1lXV0dHS1NTRm04dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882be820-d554-40a8-63dd-08de7dfa542f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:38:44.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DlIdVQsGorIkpRPH/uKApB8L4VhdPSBE++5Ps0Sz948H4Hnhml8xQEqMQSu3fGhRQGSTBMoNERR9VmD3aaJWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: A68E323CDE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2551-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

uniaddr_offset will be needed for rebuild fulldata mode. Add a parameter
to erofs_rebuild_load_tree and include it in the erofs_rebuild_dir_context
struct as well.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/liberofs_rebuild.h | 3 ++-
 lib/rebuild.c          | 5 ++++-
 mkfs/main.c            | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/liberofs_rebuild.h b/lib/liberofs_rebuild.h
index 69802fb..d8c4c8a 100644
--- a/lib/liberofs_rebuild.h
+++ b/lib/liberofs_rebuild.h
@@ -14,7 +14,8 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 		char *path, bool aufs, bool *whout, bool *opq, bool to_head);
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
-			    enum erofs_rebuild_datamode mode);
+			    enum erofs_rebuild_datamode mode,
+			    erofs_blk_t uniaddr_offset);
 
 int erofs_rebuild_load_basedir(struct erofs_inode *dir, u64 *nr_subdirs,
 			       unsigned int *i_nlink);
diff --git a/lib/rebuild.c b/lib/rebuild.c
index f89a17c..7e62bc9 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -286,6 +286,7 @@ struct erofs_rebuild_dir_context {
 			unsigned int *i_nlink;
 		};
 	};
+	erofs_blk_t uniaddr_offset;	/* unified addressing offset for FULL mode */
 };
 
 static int erofs_rebuild_dirent_iter(struct erofs_dir_context *ctx)
@@ -419,7 +420,8 @@ out:
 }
 
 int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
-			    enum erofs_rebuild_datamode mode)
+			     enum erofs_rebuild_datamode mode,
+			     erofs_blk_t uniaddr_offset)
 {
 	struct erofs_inode inode = {};
 	struct erofs_rebuild_dir_context ctx;
@@ -452,6 +454,7 @@ int erofs_rebuild_load_tree(struct erofs_inode *root, struct erofs_sb_info *sbi,
 		.ctx.cb = erofs_rebuild_dirent_iter,
 		.mergedir = root,
 		.datamode = mode,
+		.uniaddr_offset = uniaddr_offset,
 	};
 	ret = erofs_iterate_dir(&ctx.ctx, false);
 	free(inode.i_srcpath);
diff --git a/mkfs/main.c b/mkfs/main.c
index 58c18f9..c2c0a1d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1736,7 +1736,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 
 	list_for_each_entry(src, &rebuild_src_list, list) {
 		src->xamgr = g_sbi.xamgr;
-		ret = erofs_rebuild_load_tree(root, src, datamode);
+		ret = erofs_rebuild_load_tree(root, src, datamode, 0);
 		src->xamgr = NULL;
 		if (ret) {
 			erofs_err("failed to load %s", src->devname);

-- 
Git-155)

