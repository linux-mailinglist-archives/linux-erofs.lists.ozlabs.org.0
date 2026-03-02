Return-Path: <linux-erofs+bounces-2469-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOxYAfDspWlLHwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2469-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474F1DF13C
	for <lists+linux-erofs@lfdr.de>; Mon, 02 Mar 2026 21:02:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPqbw1bGnz3bnq;
	Tue, 03 Mar 2026 07:02:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772481772;
	cv=pass; b=m5PT4fSsyG34Cm0caO51COo5w8oGL+HJ0UyKb9xga9BqI9lXc4T3U5SMxSnifjR9Hj1dlyEruINvrry3WuiKQ5UXAPjSPfsNlJTcb0yQ2EADJsh7CGnEss/bJ6LtounaZ7Jdum0rOpkJ7Bma+4ojIcUHXCLzlpeTxiHOi6UGUcPDs6c4GYyjyJxgssoan1A472t63rwkL2QfkDV4YngCl98gIzGjzxwixyFfIBobH04V2B0W7Of/Q67yD5OnfM+D71hjMxLRX7uuwXNYfsOjTxbnEWfmxV0JrBUQOb9bZ8jUR2veB3YQs3nU9IeRPQw4esjhWEoure5cqKQLkCpvOg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772481772; c=relaxed/relaxed;
	bh=+RzH4EKb6wxJJLLudaXaerxHQRiUYRTOuYiqknmkbDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/04crW2xy7p7os6686NdZ/9NWJnYX3+HyVnj5WyVe5nCV/A55Hhj1eK/FMSBw0f3IC5Ap4pD4bWcVLK7KCDwPRQp2lbh/1FI+x713Jea68Q36LDw75JzfbpwaTx59QmO9k+h5c5j8AQPMptSeU9UMXQFdV2gOxokiQz0t22vXzowdPitKDOkzLUI0EyNs4XFTOODJQOfwXRQLmJ8/mEHgrl5oLSiWMZzpbz3G62e5ngZGOhuj18FQ5EtrUBfX0/QWylWHQs8KMro9lIph4Xb9/qdUITXK8ZlCp9m1EyjgiY4jaWth7VZAVsg2Vj+w2usdTES1dJB9xh6MKk6oJwjQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SHfhQUiT; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SHfhQUiT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPqbv4w5Sz3bnL
	for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 07:02:51 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5jr3ad0R5mMSTNLCjvtoqw7ircgViJJsvJAK4nW4nIpnZg2yEYqIMysMqC0SiThoRA5QFS5DDik/vpXApiV7AMQXmzE8FAyWb5r3ZU+ILQ39UtEfCqMldY8OT+L8v6YoT0WsZ62+4/cNcuKb1diQLYv7kMiNLJwIG0hI/IEfxqHMC6se44GXb20DliFqas90b90JvzUN2VffX2I13XMYA26Amb/0DxeA/514DIH0iHpnIlQvvov4zj1BltYECSpRNoFHLiezYk6eSqpobN2FQStbIFrwCCw1d1uQvLd7t+ciJ8y+tdU2hAmAUUNX6zy4e+s0VpDX8Kc56VoiD6wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RzH4EKb6wxJJLLudaXaerxHQRiUYRTOuYiqknmkbDg=;
 b=d6SbpCYn8UEj2zwxkXhZP1kMJ4w4K+M46EI+ymjzNsxWjU9M72Z6Rpq5Ioan49H5mnJzlV0+Zq2GkE2bySJqDGfl8z1VPxyTHdsZDruZrJVhKVhm5dUWVdyaz9eh2cJyPH0XoR6MvgCQsEPx0K2e+wLXJdoaZEOMFSXnA0nIYrwI/3QHvDfgxnky98dwH1I2LxAp7J0aeYXYjGAq42mQ+y/nVb7PtaAnzwJwf1ovmH0IvURkm/jbP3GTNEhFUT2VDXgY7aEgZCP61Af3AOZGb07Tc0beHOHjZGAsowMrFEbXaquX4Xr6jM+kTvYrYHgzLTAQVHjXSciNrsG25Izrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RzH4EKb6wxJJLLudaXaerxHQRiUYRTOuYiqknmkbDg=;
 b=SHfhQUiT88fih3K0lXGOwiKp4OPeyamB53Q84QEX0/2lHBvDb5xBlUwl07ywBwmFGo69A+8cfkJhFJU9UFpW7utDNpa53ouOqnohb0xyD1s3KAMGDHDO0KhNFlLoNiuZh7dUNq/04nSM79p1ZnJ2jTnB+iCF4I6XzhNuetfn4mv+ecDbrlTSn0rF7VKDDp3ddfAuMt/opNUFDhSfTsF08DEsMEZ4/o0h/L4m/WYgIy54kHP2WDm5etvXjC444ODIOJdI6pBf5VoxWELmjZUNntN6GSqfiFgsSxtJ+zmbD9FijtoIa4PCcm0MwfgOoxkBwUB370vEGBCpuKiKijhmvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 20:02:31 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 20:02:31 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH 2/5] erofs-utils: lib: add helper function erofs_uuid_unparse_as_tag
Date: Mon,  2 Mar 2026 15:01:51 -0500
Message-ID: <20260302-merge-fs-v1-2-a7254423447c@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
References: <20260302-merge-fs-v1-0-a7254423447c@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: ec46fb05-a2aa-4e23-1bd8-08de7896a2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	+VtTq4PeOR0tYH1FdWm4Sfg/jqPh7wi1rYJeOICwW/yT/LteCZC1pHgeAG5LMP6WGqvrEoDQS7SgvQT/BpW5QNiAaAaUZuN0UIYkPc4m1g3sfB2P/WHqS+dQeWNOU19PDFt+EHDk0lNgaYcxHmQH3Il9NNSS8qEoxB7kUijqQWgGMHDVCdqstG6bKEeHeaaA34r4MBg8beKSVk5WgDigb/gnghBBmVaty7qbzI1+4awBMU9OdmLH3v3cB8B+NfbN+G/MjB+JFGouuyI2Cokv1Nts3bchetNa3A0J/qG73AATvNRDC+UB7+GOGR4qs3qAzSbaLCuTmlDM/ZrQColeaqcGlGVJz/khMJ7T/D3x1LlOV3Isn7tQqs3nWYt8Oog0jD2gTOetiu4tRFuz1JClnyDXfMuAuDoiIrpRreSbNws8/fnlPf339ZxfkO5g4MR58qFu38blK5l/77n6lBm8uofudZubDwEkjOYdHctv9EQDZ/hTjruL+fWrpAaDSNMES6hc3znzT7FIe1TBj4GmWFeICuNRExXEfSu+lgweMSl6MyLnZK0Pf2l78C8eTAttdQkgGlKylgiqBB3EcSGTU7LDms1rLEN+m/8HXzSFd21TagJpYQpgZs4WnN/ez7fBGBPA/c2cBdqeTMVS50P8yCKI4cICQvvBglrQSVBm1MoPoEXasxp0+7kmlyRBQUbDRcgVSpsN/FGdSqBtzcfoS5eMLZEVNLXeKZtlFncyH+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9XcmhTSHkyWkhvc3ZIcVhOSThmOHE1WGpkMS9teVlBU3pScTZSVTZIdE80?=
 =?utf-8?B?S0lmeHpoYXV4Nk5DOTV6VjFQdC9GdGI4WGpsa2ExQnNCaVI0clVmMzFKdlQ2?=
 =?utf-8?B?MjM1V3JBaWhyUzBIMEhzN1U0VUxDUkhtcE85WUhPQ1lsUTUzSkd0VFd4OW52?=
 =?utf-8?B?TFNjVy83L1NlRmZLbUczNjF3dW1keUlLYkV6dk8yZi9nTDJlcVNFd05EdzZ1?=
 =?utf-8?B?SHBWcTdxNVZETmgxSzQxMHM5c1NXZ2lGamJKVHpoZmQ0YWJhMjhJVU9zcGM3?=
 =?utf-8?B?djFZMWNtbyt3ZDlvN0JZUWdzRVc4QTNtQVYyU3ZpNjg4VFF2Z2dOdXhEd3Ri?=
 =?utf-8?B?UmZvZ3lPNzl6bW9EYXM2bXVWbUphYmJOU0JoU0R1T2pKRkUyN0hsY2NNc0FU?=
 =?utf-8?B?NDBqS2E4RWVEYzhtd3BqZE1WRHhlQytaSys4VmN1Z2ZCRVVFMlpGWEJBa0pU?=
 =?utf-8?B?b2dMMzUrR3NaVW9FVUlkSk5uTllaSGNxWW1NZFl6SitEZnFpSWVHWXgwRm5m?=
 =?utf-8?B?SExaTlMxMkNUUmNQSC9WNVpVc0k3UnFkNXhpYkVYTWVoU0pzdUZCSURGVmhk?=
 =?utf-8?B?ajdrbFYyRVdzV29CeWFvZ0tNSDgwdjlqdkVucjM5SnJDdDdvbzZaQkxtOC8z?=
 =?utf-8?B?M1dMRVN4Uk45eDVBM2FEV1B1UjF3MVFWUFZlZVZLUTk3bHJ1emxVeUt6V0ZI?=
 =?utf-8?B?cmVML2xZZ2RiWUE2bi8yeFNCQkZxWElaVVVvd0FqbGZuOHpvWi95NHNyN2RK?=
 =?utf-8?B?WERFcTNWRGtBL09abFFaZlViaVZXRzc4dlViV3l5NklXc3pjdVVSK05LbUdK?=
 =?utf-8?B?TUEraThoQzZlOVU5aVBwRmYvQUJIYkpnR0lwQkNpQ0pwQTJhZ2JtZm1tdHpa?=
 =?utf-8?B?ZUJ4emE4RkR1SEIwT3pRZHloR2VzNHFxNFJlYlA0TERIQXBNWFdhNThTKzNO?=
 =?utf-8?B?SXVYbGJ4ZDZVY1N6bmVqK1h6QTYwSFlSc0M5MXBNeG5zRVp3M2RqT3RqNHUr?=
 =?utf-8?B?UDJnbERmWU4vM3VyZWF4K0Q2MHhWRVNmUkxDd3NmYlZSNERJc1E2VDd2aUM5?=
 =?utf-8?B?Q2tvczU3aFBsQWRSVnZnTENoVHpONVhYb1MvY2xCVXptWWdSTXljQVpkS0Zt?=
 =?utf-8?B?bDlDcWF2bEtDVUdtZ3ZxRU94TVJIbExpUHg3QUlwYnl5TEl6Nk1sak81RWNZ?=
 =?utf-8?B?VDQ3VWF6a1Z0OXE1QUZEc1F1ZGVmSE9UdTZyNFlTcFFoWTN2dENMN1g0N055?=
 =?utf-8?B?WDN3aGNTQ2pxbEdhQmh0TGlpa29wQ1BDaVQzVkN5MDgzMUV2blJQTy96UjA1?=
 =?utf-8?B?cmFJaWlzc0Z2VmtwMlpwVDAyVmF5RHZ4S2RVaS9zMi8xMGl5QnFIYzR1VFhn?=
 =?utf-8?B?bENUQzhGOXVTN0tDTDlGd2VuZVR3eWZYTzl2anNWcjIwMEdHdlJqWEh2cG14?=
 =?utf-8?B?cW4xVGc5aGtsRDVWL1dEblpQU2Q4QllGdW83dFdrOW0yQjFHbkpJUzRmRFUv?=
 =?utf-8?B?UVlzYUthaVNzcjR1QU1NT3pZbUp6ejd4dC9wSmJ3M0pWNWNMeTJKTmtCbHRP?=
 =?utf-8?B?K1lDQVRleElIM2JLbzN1S1ZhSGxEcisyeG4rU3lKZ0JKS3VIN1FwalFRSVYw?=
 =?utf-8?B?K3pHVXNjM2hrSmVYenB3aW5tUnJZY0dKY3JQVEhDQ2pjNEF4azUrdlhUK2ZS?=
 =?utf-8?B?b0p1ZEIxMU1nZXBJaGRTTGJQYVBqb0dzekRBZzloL1NKdWZ6eVcxTVlKTXdR?=
 =?utf-8?B?WkdnVnFheDU3UE1yT0FIV3Q3RTQrdjhlQXVxMWpqanFwdUNxMkpBTXJ3cnp3?=
 =?utf-8?B?blBkRHBySzVjN1VocUxGV0NwNDNMOHJhRS9tTUZlang5VzN2cnlGbmlhblY1?=
 =?utf-8?B?ZmZYUlNTU1oxcWtnVE1hUlBGSmZldk1DblJaZmY3c0xnV2p4b1FaOUdzM3Mx?=
 =?utf-8?B?ZHBrUVNQSm0rWkkrUjlmRkh2VDdsQjRnbG01aG9TeWRaKy81RXZlTUJmMlN5?=
 =?utf-8?B?ZnpCR1dKZHpqY3R5dVFPSEV6ZnZqMS9pVFgwcHQ3SVZ2aE0rKzQ1ZWYwc2pS?=
 =?utf-8?B?UkRSY01SVDlVUGYvV1A0OEhuT1Z2QkVJbWlvV0pwdmlSdVc4S3F6ZG9MT1Zm?=
 =?utf-8?B?RURBa2dPSDJCY2kwNW1ZWlRCWTFrdFoxQU5QYkFHbkU3cE02dEdva2VLdGxI?=
 =?utf-8?B?Z3A3bjEzdE9EZVlicXBCUjRJazkraWtHMHdKWXd5ajZ0ZzNZWDB5QjFQaWRL?=
 =?utf-8?B?Y2JQMlVmbjRXRi9xYUkrSEtOMzdPWUNLTHJZVnh5NWxLaXd3M0R0RElDeFdp?=
 =?utf-8?B?UndOWi9xQ2dKMUdJVE5JM0EzcHZkNlZWYlVHdlBTdW8zempYK1dSdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46fb05-a2aa-4e23-1bd8-08de7896a2d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:02:31.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDx+1R1to7kbETogamdxQzDBmm7/VTRbWOi9xVEcv1+LynZbC8uAsrkmXJieZcrRdyq5pPLsWKLz02fBWvM0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_PASS,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 5474F1DF13C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2469-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

Add helper function for converting uuid to tag. This will also be used in
rebuild FULLDATA mode.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
 lib/liberofs_uuid.h |  1 +
 lib/uuid_unparse.c  | 16 +++++++++++++++-
 mkfs/main.c         | 11 +----------
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/liberofs_uuid.h b/lib/liberofs_uuid.h
index 63b358a..c35762a 100644
--- a/lib/liberofs_uuid.h
+++ b/lib/liberofs_uuid.h
@@ -4,6 +4,7 @@
 
 void erofs_uuid_generate(unsigned char *out);
 void erofs_uuid_unparse_lower(const unsigned char *buf, char *out);
+void erofs_uuid_unparse_as_tag(const unsigned char *buf, char *out);
 int erofs_uuid_parse(const char *in, unsigned char *uu);
 
 #endif
diff --git a/lib/uuid_unparse.c b/lib/uuid_unparse.c
index 3255c4b..18e87d1 100644
--- a/lib/uuid_unparse.c
+++ b/lib/uuid_unparse.c
@@ -8,7 +8,8 @@
 #include "erofs/config.h"
 #include "liberofs_uuid.h"
 
-void erofs_uuid_unparse_lower(const unsigned char *buf, char *out) {
+void erofs_uuid_unparse_lower(const unsigned char *buf, char *out)
+{
 	sprintf(out, "%04x%04x-%04x-%04x-%04x-%04x%04x%04x",
 			(buf[0] << 8) | buf[1],
 			(buf[2] << 8) | buf[3],
@@ -19,3 +20,16 @@ void erofs_uuid_unparse_lower(const unsigned char *buf, char *out) {
 			(buf[12] << 8) | buf[13],
 			(buf[14] << 8) | buf[15]);
 }
+
+void erofs_uuid_unparse_as_tag(const unsigned char *buf, char *out)
+{
+	sprintf(out, "%04x%04x%04x%04x%04x%04x%04x%04x",
+			(buf[0] << 8) | buf[1],
+			(buf[2] << 8) | buf[3],
+			(buf[4] << 8) | buf[5],
+			(buf[6] << 8) | buf[7],
+			(buf[8] << 8) | buf[9],
+			(buf[10] << 8) | buf[11],
+			(buf[12] << 8) | buf[13],
+			(buf[14] << 8) | buf[15]);
+}
diff --git a/mkfs/main.c b/mkfs/main.c
index 471bce2..a8f9a5e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1780,16 +1780,7 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 			memcpy(devs[idx].tag, tag, sizeof(devs[0].tag));
 		else
 			/* convert UUID of the source image to a hex string */
-			sprintf((char *)g_sbi.devs[idx].tag,
-				"%04x%04x%04x%04x%04x%04x%04x%04x",
-				(src->uuid[0] << 8) | src->uuid[1],
-				(src->uuid[2] << 8) | src->uuid[3],
-				(src->uuid[4] << 8) | src->uuid[5],
-				(src->uuid[6] << 8) | src->uuid[7],
-				(src->uuid[8] << 8) | src->uuid[9],
-				(src->uuid[10] << 8) | src->uuid[11],
-				(src->uuid[12] << 8) | src->uuid[13],
-				(src->uuid[14] << 8) | src->uuid[15]);
+			erofs_uuid_unparse_as_tag(src->uuid, (char *)g_sbi.devs[idx].tag);
 	}
 	return 0;
 }

-- 
Git-155)

