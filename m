Return-Path: <linux-erofs+bounces-2833-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC+uB52xumlGawIAu9opvQ
	(envelope-from <linux-erofs+bounces-2833-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 15:07:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 771462BCA1B
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 15:07:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbVyJ6HZHz2yjV;
	Thu, 19 Mar 2026 01:07:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773842840;
	cv=pass; b=VJxGSWabKTcfoR91YG45iA/ghKbJrt0AsTfhQmbEK7CQoTJ/Tuk7mGBQkoNs0pU6fLeoywVwuHbmkSBQOhXq8LyiL2T8GsSFHO2GgCb+srXB6hgiUAlBf6vOZSlO7GDqwvuEbXYvldG2NVzwJyUiZ+v6PjHKs2JS/fr93saq/vbW2mEWqBDi0J/7LVtrugBcBUaEWAJ6v+Rwwgy4FQj3tdGs5pi5UwB07U4ta3QRE/1X9erNrJwBf8uSJ9AlU7o+opdfKHI/9BxBagOtj6mWdG2MXnUT87TRJ/gSiLAYomKnhlpEyK2xTjL6TK8WnGmkKzq+h+mVA88FYX8PM3f0LQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773842840; c=relaxed/relaxed;
	bh=VqnCLfQBg3WwfneXGq6Bj/6w6XXMKC0sltxgUhy7S+0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VxYLmerl5AWddCxzinMl91aNcK4C0xjXhR87sQ8dX5DXClMkrXWQ8oeBy1Rf30s6iSa5WxWeaskYSgcoqP+9LwqqeKviWzm9+Z6ekhaM/IOys4P3AvMZbiY749DoorPnRVHmhvR+ULwua2FS28XQUtJpFRZVjcjy/+4xOXVc70bRQIYh7wDtYIYVPRkEH8LUdNv/Y50UbWwnsz2MMijr5Pso/6qOvSUW5rWHvuwlnCbDs7doZlD+n18h6z/cRhQVqJIYpM/mQSs/LPOp/QxnzMFEw951mMrQVFe5I1NpZKl0RQjciIbtcDwf5W5fPSzqSvqSnmAHYFEQpAqNfxvw9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Nelwsr77; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Nelwsr77;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=lkarpinski@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbVyH0nZbz2ygd
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 01:07:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVbZw+iQw+a2fwxxS28hUjgnFodkCBJmNxpSqBkQthXb8mObDOTFSHMxBZowolqFIqZsr+HCuJjKO/hrgeSsXfOwk901ivIDo/Tc4VbC0PpCYdpmuPe+raN6yAaJk7StQG3j88NvvYJrOHOhIVoPJHa1lwnODTmtJFitQmysL0W2Ouc8xQYgEwmDNJTeZ8tUHCUilMla4nCMEA9R+k94jx+JzSCORYc7LKPEgitvqTIdE9mQCXBH6OSDUm70aypzWBpw4rHWOTWDyKJJDHtMW21JUAqsOQ0BUpPpMgeeG6D0tMNDvlM2cYp2BjKrD8IrRmA95XcxIYEa2Xtq+oJBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqnCLfQBg3WwfneXGq6Bj/6w6XXMKC0sltxgUhy7S+0=;
 b=nMuISQHWVAlKldRT4AMlBob60qX0FAzy7y15ZxIgn6q18T0o3ClsemRKRXmFN5hqfuVA4YfdS4sY/lpK7WGbtuU+9MrT1SNKDdM6sCK4eogOL77+gJ4XFkf0vpTAvgR9BEQ3QcevmEvWEXYumE5gWM6XRhWHzAVxIPZkJ6hHU/qAATymFHUDn2uNGLvR9kygPIR0JTTu7MCauo1lbyxz0XlSJ0Udlo5B/aPh7Dg5xFg7wP5W+bfYAExDxjXC5bLV3+KnbTGL6Nd5Nxoq7xiyAT+PZuDfO9y4aXt9pEl+5xbG6OS15jBE39vvO2QRUm4/C4HwwtEemKyGULCV70DUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqnCLfQBg3WwfneXGq6Bj/6w6XXMKC0sltxgUhy7S+0=;
 b=Nelwsr77T/nOXaxm8PxspIaPIir/CgZ0x2rhfBJTShJ6BIwJSUyXIcNv1kQSIwhUj78jwSB2HnZojxDJOVwNSXCU79AOpeATPHFgiAN1xjWgNUjuU7x59mkUcGI1vG74+cg2y06KueJLVcn1UcfQPqLd2KdmiQHlsqtnPfyhViF9H9VBArQ4zoOqJuNNk81tuNvabQFn0IUlDbPyO2zFzliT4c28orSqi0GhC0ucWV08c71iMv9pIGaU50Z/+nHBbL4YfdqlZ40+rdmGxVtQsPnvz9Zn48zcyAtXxeKnKKDlBhKnNsAWhk8xX9shO7SbQwxEoq+qU0N+tjAcoh2Clw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 14:06:52 +0000
Received: from DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a]) by DS0PR12MB8502.namprd12.prod.outlook.com
 ([fe80::3533:c307:cf11:3d1a%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 14:06:52 +0000
Message-ID: <1b7a6e1c-e1f2-48cb-a947-7f5c7f949cea@nvidia.com>
Date: Wed, 18 Mar 2026 10:06:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: fix potential NULL pointer
 dereference in docker_config.c
To: lasyaprathipati@gmail.com, linux-erofs@lists.ozlabs.org,
 gaoxiang25@kernel.org
References: <20260316085300.19229-1-lasyaprathipati@gmail.com>
Content-Language: en-CA
From: Lucas Karpinski <lkarpinski@nvidia.com>
In-Reply-To: <20260316085300.19229-1-lasyaprathipati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To DS0PR12MB8502.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB8502:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 360517c5-4beb-4fcd-8de8-08de84f79ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|7053199007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jYmQxWVS5ywApGXBDNcWWDhCaJxxKxioZnW+MyoYBreEYrgcapGJyX7OC1KuRnYF5caNEAaqBiCfT0Q4onOPy7kRYZbfy9jQSXLBBMB1Dofa6oTb/zZaEH404V03WF1qgRnaE4si9sATk0yurt04OgNpsB9EL4BMKdWLX0hiSqDK7WtMX2X3jy5E0QncL9yNyuVRMyHMu94aZ/aOIyRepeD8GQ3b0gRK9Ag4d3zZjVtlsj3XLDGBPDbxM4azTurC+QD6NkQvqHtsDzu55i77x+forg9YIqOGSpZFcRveZTZCH5EBJvK7aXtYlzJqyd5jAv/2YsxeMCh0JoqOMRHWbbdn2jLcV1Jmv02U3CmNQf+NrCi7VfzuD3g3Gw4vankzsXABW5UU/iE7OuGaS2FTsvAdi/ysFNgaF4TpcgJnqJOoKXmnn4pbXSxWg5H95sEMrF1uBamQ96hC8dMoy7cuxXvDE9fMjqsAJMkOpB3Wy8pDj0BFjdgNTSYibSL0l1MPKNUrVcG7G3nsuZ5lNitKoXdildmSZoqokJLG7bRmnRrVMKqYVPmkw7tMQjX8su/Ae3Kz1/dcqRz8d4Hm98TFFeQtON8onxoss+yPAb3+Z+5mihMLEE8YeZvqs74uiX1G3aEvGnfXPUTY9L9DPBjBPKJyTys3P5R8URxm4NmExn7jLI6PEY9Mzb7veG24qA/0MbDw+GlnKQUtorsNhNUYF5whMyTQeM+enr1LxiBIkZc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8502.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(7053199007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFRiYWFldHFKd1gzSG0yVzRHbXM0VUt3Q2xoQWVXV3A2bExLeUdUcnNqMktl?=
 =?utf-8?B?bW9JWmVLOXRIWVRmTXZQc2tRZTJRKzVyRVV3YmdBVjJxa2h1V2xIT2ZhbVlo?=
 =?utf-8?B?aFlpcFNSY2JjcGNST0tnRzV2TGJ2UXF5RXdZMXdRRXFkeFZXZy9hOXVNUlNH?=
 =?utf-8?B?WVlVejY3TjJsQWJ4VzJIN1QxT052eUpGOGRURDdxUUxzZ0JSSXhvOCttcFJI?=
 =?utf-8?B?djdFT2RkRkFnQ09NcnUwMzBROFhBTzZNZkk3Y29TU1Z6WUdGRVRlNUo5R2Nm?=
 =?utf-8?B?UUZ6MFA0c09DaGgyeUJDVkd0RENkenl6c3FFSjU5TWZRNzJuWENyeFpieVBj?=
 =?utf-8?B?eEkwRGd0MmdiQ2o5OWFacmdBalBJM3BHY3h5elc0aFRmdUpSNDZZRFBVZHhy?=
 =?utf-8?B?cGJXVjE5SmRyM3NhYjAzUDlQaWNDN01WWFFPNVBINzgrQXlORTRRL3ovTDAr?=
 =?utf-8?B?SVMwNUdBZ1VlNkY3VFd1c3NkVUNRSXVQbFdEbTVRbmMrblRaL2Yyb1NzWUFw?=
 =?utf-8?B?MUlzeTFRcXh0YTRUR0dWbFREYjhGRWxVUGltZHAzbVY4MU1qNk1Ya3FMcmg2?=
 =?utf-8?B?RzFsaVhrRnF4d2RCWUoxT3JsNVBkSU1sU3lDaDBlcjlXVDJpeDd1OFpnZER6?=
 =?utf-8?B?RjhKeXdBbGVNYVRFSzkxb3NPR1FtZVZDUjZRV3BJbXYyYW5IWDRKdjg2YWZx?=
 =?utf-8?B?UFc1WXVvOHZPRkJ1WHhWbU96Ym5JbXpGNUdvcmE1Ukg1UUtJZlk0K04xZnFO?=
 =?utf-8?B?OFZNTE5XYnNQako5bDFVTVNaRlZEYUdubStWcXlGcEV2bktyemgxbm5GVHdN?=
 =?utf-8?B?Rm04QTkxR05jdkZKSUdXUWRaVHZsUGJ6dkR1VlRmK213Mmd4b1RTcmFHVzRM?=
 =?utf-8?B?b2JSR2tJWWVRSXBsQUZOTFltVkhyRm1PaXdZMnpqOE1zS0xrUi9ic3RmZnFV?=
 =?utf-8?B?SmZkS1N6czhtTmlpZG1oYitlSHgzd1h5RnVDeFdBaDZvQlRxTFB0YUw4andI?=
 =?utf-8?B?ZkhXMTdGNG9CSm44SnR6OUtWcU5PSGtoSEZaNWtQemd3clJHUC8reXZONHYw?=
 =?utf-8?B?QTFLMEtUVjVldjFtNDdDT3VmeTV1UVFZcExVdVpScHJYaGJaMzNlMVFVUUxx?=
 =?utf-8?B?bXM5VUIyNmptMFNubnhtamd5ZzRrV2JxLzlIL1Z1MFUxTlVFZk5ndDNJSVVQ?=
 =?utf-8?B?bTJEVVBUVHlsTzVnUVo2YXlVeXZpMW42MVptK2ZRc3YzOGhYYnJIbTh1azJj?=
 =?utf-8?B?ZTFGYUgvZ2cwVTBQektCZDVUTHBqYnhBT2VlaExVaHh5QklSSEJOa1NLclNG?=
 =?utf-8?B?ZXBmUWdYeWUzRXIrL3hHdmRUMkNSOHlUOEY5eXJBbkxmVno0WHB5TVlaTHFt?=
 =?utf-8?B?UVJDaGk4V2d4TDZXb2tkUUd2ZTRmK2FYMG9Oa3dFd2Rqd2x3RklHeGVoSG9W?=
 =?utf-8?B?cVJJazFMck5tZG5iWkJFMmFaTytZMExGVFVDQ2phTDk5QzZvYWEwb2lnZ3Jy?=
 =?utf-8?B?dEJWRHAyZXkrckFpejlLS3ZrSWFQRWFNM2I5c1hsTWFJaWszMkVzNnNCVnNy?=
 =?utf-8?B?QmNkYlo4UmRaUFg2bjZnU3A2SW9lOG1tejQwUUhXcUFPVVBaU1RuK05RNysz?=
 =?utf-8?B?VmllWmloMlo4eEoydEhWbWNZTHVPL0VkdGU1azZMZkF2aUZrUS81R3MxWU9Z?=
 =?utf-8?B?L0ZPbnR6eFNtQXFUT0wwZG05Y3pKa0xOVW8rTlNuZFFxU2R5alV0Rk9zVStv?=
 =?utf-8?B?dnkwaHJkdk91UmxBMzcrY0RJRmE4MTFuUWtTaExIcWNCblFXRXZ0cFVaMlE2?=
 =?utf-8?B?OUl1Rnh4bjVSeEtvTUU5RkZhUTZyRnBNcEFCR1hIMzd1TFJTMDgyaFFNVmVM?=
 =?utf-8?B?QmFJMGJPbXdLVmNBV01Ra29iQzEyYloyb2JJTU8zdmZzU1hrcHp2ZTNDNWUz?=
 =?utf-8?B?Zng5S3BrQ1NIMlFSNTR0VnZ5WkFzQjREU2hlL29LcE1KU0ducUJEWGl4UEYz?=
 =?utf-8?B?V0FUVEc1RkRuVHhZcytKWWlNVFhlckl6L0tLREZsdXFMUUpHRGFkSTJRY1FC?=
 =?utf-8?B?UlRNSHcrRWpaaCsrcVpySFkwQVRIdHdyVUNPTXkvZmxkaDNzSTg0ZjZabUY3?=
 =?utf-8?B?eFBlZkJsbzg0VCtEdUVXUmhOQStpRUpSOHNoRGg4eXdtaWhoWlFLNnZzRXBi?=
 =?utf-8?B?YjVnOE92cWxFSnRoblA2ZmxNVmtCMG9oS3dvR3daNWRqVzlTK294aUJ1cUNi?=
 =?utf-8?B?bEl1RVArKy96aWxya2IxVVJlcGlrdjBGUkhra295WkpoK0s2dlFsNnFicENN?=
 =?utf-8?B?NlpmL2hRTUhGSGxtVXRLemovVEtHTlZCZ2p5cm4rN0hqc1BmS083Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360517c5-4beb-4fcd-8de8-08de84f79ab5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8502.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:06:52.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgVMNrVIBGMf8IFkt2LRwVjbR1nmxUqfOujHmnEN/rkZMLVn0Y7pBfSJXLoA9t3TSAdPe1HuDXSGQZg29dWPDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2833-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lasyaprathipati@gmail.com,m:linux-erofs@lists.ozlabs.org,m:gaoxiang25@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org,kernel.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkarpinski@nvidia.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 771462BCA1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-16 4:53 a.m., lasyaprathipati@gmail.com wrote:
> From: Sri Lasya <lasyaprathipati@gmail.com>
> 
> ---
>  lib/remotes/docker_config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
> index b346ee8..6401c1b 100644
> --- a/lib/remotes/docker_config.c
> +++ b/lib/remotes/docker_config.c
> @@ -202,8 +202,10 @@ int erofs_docker_config_lookup(const char *registry,
>  		}
>  
>  		entry = json_object_iter_peek_value(&it);
> -                if (!entry)
> +                if (!entry) {
> +			json_object_iter_next(&it);
>  			continue;
> +		}
>  		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
>  			b64 = json_object_get_string(auth_field);
>  			if (b64 && *b64) {
There's still a tab issue as Gao mentioned in v1. This looks like a diff
from your v1 to your v2 patch. Similarly, you also dropped your
Signed-Off and are now using a From.

Lastly, you submitted another patch just yesterday that includes this
change in addition to other changes. It is very difficult to follow what
you're doing.


