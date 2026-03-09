Return-Path: <linux-erofs+bounces-2546-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOTuDrn3rmnZKgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2546-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8F23CDA4
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 17:39:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV2ln2RjWz3c9r;
	Tue, 10 Mar 2026 03:39:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773074357;
	cv=pass; b=lI0GYKLTV7RNzlWIw+5c9qCnQJm0P4JGpwxDkC46iAMiC8EUIWi7QYxuT0ohjkiJqnaAq0QpKEBng5C8Jc4EFcfBAUV/bTbJkspHmt/X2nL4Dfby7qR8K+dw1/u/mk1uUmLcjhj/YcgJ9qtZx+Obu3xtWWr9g2YIwOEt0T8PRL7h6n47boRJ3rQVOMHcDpO7BNwLK2X3MLkrpqd4m14e3lX9CrfPQaQd0yg/oduEbTjpLjfRhnT/hKp21qODHfg3X2f7cAH55l9yfC0WbCKH+E8MNwshopFiUO67G1m2f4MxABROdi7DiHbf3AnrbGT06k7O3513z7kPDPvUkkOXdw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773074357; c=relaxed/relaxed;
	bh=ELYbY/8Klbd65f6MaHEMctJ5KJ56Dag1+LiHg7VI9EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wd6s0sfKaRkp0IAqU3XyWzkDdHnV5aAS1cyr1ku0+GZwMCRa2uqQDLGgZgga4ohfSxAHFaqeh2i0+oVEt6O4VCsP7hF/SACbpCgsV2QvdH/ESEhmNcSFGGZoFaG5jt41CBpaBkgPsd9VD0fCF0ikHay4eKWpncl32oV/J9az7JUoHoE6g4uyfOVkNaXW5AeOSFhdNSM32rWCY4Qo2+I1D9N0JrNC9XBYRM+w1x493/P2MThGlq/dTR0tpmWfai1aav2BiaAOGMdjZEIEsxZgB8e0rR34Ba1HT01TJHQBtg/wmyDP0LWcOMitQUN/JR0yeY9AJ90URkPPBi5yfH4U9g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fLpqK9ye; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fLpqK9ye;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV2ll65NQz3c9l
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 03:39:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX7XQCBqQ1D1kc1uBcB5Az+a4NC7Gmv6E71UIKSSepno5GTIk7dm2q0Bdd2n99yF3px8pE8nro29+fL8EDxsNHv2ydgdgAdm6oRPFjeVJDrlk7tBpUyyJt/wtSRZhsJbEnb2xDbTRS8KDG3E67UkMTowKlpEFzym4R8ws9yHnaFAHl0Pc/5R5bn39hLvTQrPF7YuRTLGxkSOcvjAMJM/pHJN/yihUXpGnFqQ2sCBGmT9I8bHrqWaWuF1JPzxee4elrOB4M5rxFYkiLh7VkKSawb4Bm7TD4scsECnmiE+mBzo8m+A5HxaZ/ofPts4HDqJXNVgVVv8fPOqy16yHRaQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELYbY/8Klbd65f6MaHEMctJ5KJ56Dag1+LiHg7VI9EQ=;
 b=KSWpKnYlSDYjut+eAlwI8HZElkr6UTvj1Nv4Yv45eeYvYJzwkYvOwK3amJr8SgZ3ONxR5S0YLZ7AaNHht6GSa3wUAVC75SlKL7U159wcLmhQIGDGI/+h07dzacRI1zVTzYtILlqiKNVniUVGSxtQlwokjQnUZmwQ5fhUY5LXF6RCQmvDTSGHeKWZQVhOXFw1N6Vyr/DufeBPaBWPSlXJ2MQAxSTmvdFEoquRiymmIsBPznUDRuo4AqXllCrPzHARR8X/rvxsR169dWVQLeqc7eXXRgTMUBCnNo3/kJXIKFIeMRnre8yvFr7msf2UUj+E24Oeo1FRXhA2zsZB9NFIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELYbY/8Klbd65f6MaHEMctJ5KJ56Dag1+LiHg7VI9EQ=;
 b=fLpqK9ye2eOm60FEHEYTlAFpRr3Tfm6p2b4KoY+C15odm4tmwg4tjLGy/3xGyC3VR2bTOQV6cDPcMZFQJDZK3ekI7XDCbcsGhpHIrROGfDynPo5A+0gjaQERVozNWjeVqrZv6x/QgN6AzamIoCQ8Ohu61Skyn4JMBMAqEJOM2ZbPBESA5eFjWh62X7wCTMjY7SAuoU5yyxgfVYbaArq7w+rcB/iZassv7jByhfno2KmuNIyq6GdnjWAfTgF4b8wGOrnKqUap4bjftR5+ln1AMmiivQ2XCEgPvyxsquxbGrtwFwZ/33A13MzBuY1geEpbX9QWgrWINqz60HuSNjnmeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 16:38:44 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 16:38:43 +0000
From: Lucas Karpinski <lkarpinski@nvidia.com>
To: linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com,
	Lucas Karpinski <lkarpinski@nvidia.com>
Subject: [PATCH v2 0/5] erofs-utils: implement the FULLDATA rebuild mode
Date: Mon,  9 Mar 2026 12:38:16 -0400
Message-ID: <20260309-merge-fs-v2-0-2dd0ef53db4d@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260220-merge-fs-e6231a3a3a1c
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
X-MS-Office365-Filtering-Correlation-Id: 1af17d36-59dc-4af6-0618-08de7dfa53a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	SojR7Wi2e6SoHFdO/M3D+zDv90vZT9gNkhgCvg7R7V0XmFj9Q5hYpqVSRvFtzVq0C6teAJZ3gZcBT9n2Ws+4D8ZXzJpIymZE4h6ChWikORxc4nU4S1nJacutQ8CAJp1LosIsDqaXfAuJxLkHVZ62kXY7DbjPZ+lifeNFL2g3fbeaxDhyBKfSP5gdPh7IOLHaSHOEi1LC4hIObFso/Om3KwPOLP1DDl1UPZkceo2bXQEUp9w5jolofGaVCgGhtQ0kxEER7keMMLz/70XgiSfA2dSYpbFaWmIKlFeCGEQN7crsAPgt7hOtIwABPzBQjKFAw9kl11G0hAV1NdHQUxx78o8E2Q4d4/Gb6mzEPY7bq9TrFKLDpadbsr2xEcQdkahrW25w4UxSH8n/e5dWgKm67LZl32us6wKF/V8IXVbYJPgvDsVm8uFGvsteuHy53wFB1eCAb4zBbJhexH596lJleqpYqy0Ajg9DP8QHNQzf7eis3zdFKQoOywplauKGqaaFop6xgKEDyT1o20E6qNtzylgLD3BC6AKYArp24TwiAXBXMLAaKFF9jOJ0R2Wx3BguTSdUrXCyiE7V4SMVJSzSOBe/y2bHZTSeMKeaWS3qA0Nsg09QyaesMskThU+UvAVHFaD+M9NfCYej4j8NOGXMhFZO5m9/Z3dQDwMsHBmR7uHsJIkqw3XMoXpGyUpVGSVSp5fo4upWt0ErRYGc2liSLOp9CRO0yeY+uUP3P9QS2Tk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVNyYmRZYTZiVEtER3FTKzhUbVZIMGZyWmQ3M0dxd2dGUkZVc1VDLzVtb3hH?=
 =?utf-8?B?VXhmeDlSMm1jTm1iK1RCU2M3N2tWK0w1dVNTaTNCdGxaL3g5dSsvM01kbWo3?=
 =?utf-8?B?SDJsd1FicG1MMVAzcjZWRTJZNHdNcjVHOURhMGVrWEE5VWFPc0ptZ2pVMnkw?=
 =?utf-8?B?M2FJUGZaRndOVzVNK2ZSS250Y0hkcXc0RitRaHErcTNlZ2FHdEpPYW9BcWd5?=
 =?utf-8?B?cnc5SklXemh1Y016TEFmMXk1a215K0kzNGpWdU9qeFpHY3JULzFpR3B1QVFu?=
 =?utf-8?B?Qng1dUtoQzBwbFZWZ2p0b1hWeThyc0JDaVRzWWtzZ2ZLSU44Q09EbXVMSTNy?=
 =?utf-8?B?TEorVmtZNWpXVzRhcENPbTJNVDZSd1R3U3JrTzBnK0ZadkdWdlpOWlBYZFZG?=
 =?utf-8?B?L0hTN2tSUGVPeTZkbHpQcUdrc2JrOFRPYld5bWpHUHIyNC92ZE1nWGoxNmMw?=
 =?utf-8?B?aFIrTUk2WERUNGdheitTVUNxMjQzTm9jUzFnR1l0cCtBSFpZdzBvMW50STl2?=
 =?utf-8?B?UFJWTGZ3dHQvMkNtYUpGcjRIaVFNc2pCSE11S1IzaDF5ZDJ4MzZiY0ppTW1F?=
 =?utf-8?B?OGhKdXUwY2ZWeEthVWxwYTFzSjNkemJ1OFJBaTRHOEs0RGpZdkZ6RG9tVjJn?=
 =?utf-8?B?UEVZUThWY1JkTkppNlJTd3ljVld6ZEFXN0pZTzY2Tm5mOG5rTi80M1BFYjhh?=
 =?utf-8?B?bUQ3SDZHbmU2YjdSTlFjalh1bGNhY1d3UTdvNXpQODhxeWR3UkJOTGdNbDdQ?=
 =?utf-8?B?QzBIdDlvUEpycU81bGE5dXlBSFEwdFMxbzNSbGdpbENEekdJQlpyNUxnQTVs?=
 =?utf-8?B?eCtlelcyM3FNQkhhQ0tBcXpabnN3WUJ6allxOUZqRmtyMFNhWW5FT1RxK1Z1?=
 =?utf-8?B?VWlFY3RwL2dLM3Z1Z2p5QzkyUkd5cFB4VEJOMXY1SG1XdTBpM24veXRNTTFy?=
 =?utf-8?B?UHRqeE1aZ1NkZ1RScFcrakxLRW0rSkZ2WWc2dWdIUnBzR3JyRS9mRG50K3Fi?=
 =?utf-8?B?SkE3TFVJYUJuMUpPMmpGRkw4L3lKTXBwdStQY2VRM0Ryb1picEgxemlIeVQr?=
 =?utf-8?B?OFB3eFNWQzh6UksvdkpjNHVLSjFDUjlnczhvejFHYm9EWUhBMVI4ckpxalEw?=
 =?utf-8?B?akMvbWtQUzlsUFRFYVpoY1dXY294dmExOUNCcXJzMHd4UzJST0hoa2FZdEwv?=
 =?utf-8?B?WWxhcllmazk2dTNUdEFodHh2c1ZIVkZyQkdzQmwycjdJZjMwVmsyUWgwd2pH?=
 =?utf-8?B?U1Q2THdLRnR3VjNJQlYzTThFcFQ4ZUF0dmhSMTFPOSt2c3JjL3VOYmE0Y1NF?=
 =?utf-8?B?L3gxM3pOTzh1eUMrdklLaUljNCtqd3BOSVlxWllJbXovcWlybGZiYnVnZ25u?=
 =?utf-8?B?L2oxU0ozeDU4NmJjM1V2b0tzVXVHUzBRK29rVEp3Nm9rUUQvRW1WNmhUTjN6?=
 =?utf-8?B?S1JaVXo0RTNlaEJKbG9tSW1hMkpwL3JEc1d5R3Q2NVN6NGFUcVVDVEVPL0tR?=
 =?utf-8?B?T0xNRlNNOU5RSlJKL2sreENQZnhhWWVYQ2tjQlhvZmZ3dnY5dXoyOXJ4ckNL?=
 =?utf-8?B?VDkyMm1FY0ozNm5HdnlpbHQ5UXRFM1dPcXk3KzZnTVRwdzVyemxQeFdVU2tO?=
 =?utf-8?B?bUtZb0pJZ1ljZVNPdURPbk9JM0JjUnkrVlJ5N3ZjdlNqcy9QVUZVSGFjR0FI?=
 =?utf-8?B?VVFqQVIxanM0SHNUaldseXIrNTlQajI3OUw4QXV1SHozZTdSQ2krdmUxTUZj?=
 =?utf-8?B?d1Zuck82U2p6bkNpVTI0SzMrakppdWtjcWxKRnQrOGw2U3RaS3hhTFBqNjFL?=
 =?utf-8?B?Zjl6eHFUbjN0bElRLzhBZ2hNOVBNdkV0OVI3djlwdk1xc1ZRaFEyaVgyVjlh?=
 =?utf-8?B?MnpSV2FNaVRLczdYUTMxaVJzQjZaOS9OR2JvV3VHVjFoeVVhd0ZtQ1ZjV21K?=
 =?utf-8?B?eGY4WHFUTVNvT3pOZWo1NGVLMWRNbTlDZnpnc1BqUTQ2S0ZTeHNTc3lpMjVQ?=
 =?utf-8?B?ZjBuN0NjUEpzUHJHeklIOEhqMDFRVDNnbTY5dWZwYVRXbm4zeE5idnRGYVhF?=
 =?utf-8?B?ZndOZGtwcVNnQlhJUEJwV0JSUWJaekNaTDFQTlVpdkNHTkd5QS9UR09TQTlE?=
 =?utf-8?B?T2RVem5Qc0o1YmRNVktydk9xekxvbGZrTGtDUUtaRFgrM1BnbjY3aDJoR1Ja?=
 =?utf-8?B?dXF2R0w4aGF4emRZMVNTazRKV2Rqd015ZWI0ZEg1Ris1a0pYU0U0TlY2TVVV?=
 =?utf-8?B?STVzZkY0dFdJendxb0VTcjQ4N1NSSGpJd1RMazl1UElsQzZKSjFzYURyMEhZ?=
 =?utf-8?B?VlQwNDBNQStqVXB2VUF1VmVyZ3hlMGdPbXJRUVBZdHkwblExbU5zZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af17d36-59dc-4af6-0618-08de7dfa53a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 16:38:43.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWuNG2ckkwxTSfdHeDbQfx5zOy3AEVGOxMP27xEMxpiGEd9w3uyx25xIp/99tpIdMBufBA7T3ZblNEbABJrSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 58C8F23CDA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2546-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

Currently, erofs-utils supports backing blobs for multi-image setups.
This implements the FULLDATA import which allows for the merging of
multiple source images into a single self-contained erofs image.

To optimize the rebuild process, erofs_copy_file_range() is used to
leverage the copy_file_range(2) if available. This bypasses userspace
buffering and enables kernel side data transfers.

Verification:
1. Created a source directory containing flat inodes, inline inodes,
   symlinks and absolute symlinks. Verified data integrity by comparing
   checksums of files within the mounted image.
2. Built same image with default rebuild and rebuild with FULLDATA. Then
   ran F-i-f/tdiff comparing the two.

changes in v2:
- reworked erofs_rebuild_load_trees_full into
  erofs_mkfs_rebuild_load_trees.
- removed --merge option (use --clean=data instead).
- updated man.

Signed-off-by: Lucas Karpinski <lkarpinski@nvidia.com>
---
Lucas Karpinski (5):
      erofs-utils: lib: pass uniaddr_offset to erofs_rebuild_load_tree
      erofs-utils: lib: add helper function erofs_uuid_unparse_as_tag
      erofs-utils: lib: preserve primarydevice_blocks if already larger
      erofs-utils: mfks: add rebuild FULLDATA for combined EROFS images
      erofs-utils: manpages: update to reflect fulldata support

 lib/cache.c            |   6 +++
 lib/importer.c         |   5 ++-
 lib/liberofs_cache.h   |   1 +
 lib/liberofs_rebuild.h |   7 ++-
 lib/liberofs_uuid.h    |   1 +
 lib/rebuild.c          | 117 +++++++++++++++++++++++++++++++++++++++++++++++--
 lib/uuid_unparse.c     |  16 ++++++-
 man/mkfs.erofs.1       |   7 ++-
 mkfs/main.c            |  53 ++++++++++++++--------
 9 files changed, 185 insertions(+), 28 deletions(-)
---

