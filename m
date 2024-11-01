Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC99B911C
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Nov 2024 13:26:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730464009;
	bh=6fj/Tt8Mh3R5X8jsO26m/jAV8kSDrOhsc8WjA+p6VIs=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=jRv3wsRZ2ab83kHIjOlWLV3xJH51uzWNB1RpaPC3a4rXVzsMoau/u0/5IbwVxMCEs
	 c+ayHFDNd5NT3NyqEjpWYYFrxxX+sbrBpG4YC3ors1OYU64ynm8q8oiTs3BwlVWbbQ
	 2ho3hv1Y+/7KC8fw+/XQC3rIg0brqxoSxhgl2uMhmrHAhpokeZaoE+1XCyKutsCCXC
	 DsNsa5Hw1NM0kQctzHpQn5jPHDPtlBGOEcSObqzmYaAGA9lu+lU3yad/z23n0lir5O
	 6SpPmYLvvH5GRMz2l+tYDGjB0EfuPW8nmhLVUiRV+W2DrXuYA4qErLuzcGD5vWS21A
	 Nmtkgjl+qCeSA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xg0V16K4Hz30f4
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Nov 2024 23:26:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:200e::62f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730464008;
	cv=pass; b=VCkeXF03d36eaxbk2uhA4USQkFQepgB8xBeU8I4lhf2LmQXwc6A+8bxkjiGqds3XD/xJWecO3pY4I4Uou5sCZ8bzqSqRkbd+RFUNvJGpRrlRoKI+g3xOPYF6SgWZs/UnHLqCnAq1FXYN6rFFbrJpFXv+FmVxryDT7znmbZbGviv77VUVGSnQTEjeIyZTbEsh1yZi1Y7kcyaOfeZwZyS0aI4mi2+10QtTATkOX1oEjTCG+BjqIKXTbn8AeeX/rd4zCEO1+5yvPIpkTMyyXCnaeTzUld3S0yafEBg1l/kZmDOnpVG0Uc9nECFZiM9jTNXhIJNtyLz5jra9oSOfH7CY9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730464008; c=relaxed/relaxed;
	bh=6fj/Tt8Mh3R5X8jsO26m/jAV8kSDrOhsc8WjA+p6VIs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lQPhqRxXhpD6xM7H69J82l70jbBWD4eSTc4RVgSnmu1dFai4cYYFbEbV8WkkXQ6FBuP/lwBNjhY73bqjj0dYNLYtiJcfcnYXM6wEH9SxfY131rMo5brPHJyS8YCCO2WMYvv1MCPbTMLcCFE1NdutoUcpO/GKqUXLUf2gI4mWrIQmHHDb+ntkOqqleRs7D8kHS7E5MTfx+Fx8qZ29XcfT3Q3d6bJnSIXpizcJztOdkoCgpDPlXwQrnFNivSnMSZwOwHB0ALDB2fd7/S2h6MUQa8LFq0jj9b9YsCnq8Te2YQl1DQrRab9etrhvALu5YzELZUQpKNhG97m7GJiNSuqhHQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=KoK/s2aX; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:200e::62f; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=KoK/s2aX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:200e::62f; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=guochunhai@vivo.com; receiver=lists.ozlabs.org)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f403:200e::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xg0Tw5HGMz2xWY
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Nov 2024 23:26:43 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCwbRM+D17iWxIM3raEOxCr9zIkP/gQ9MV61aO3RtgJFeL4dVL7ezJLaUQpM3z27OQ0/sJqOWsadcVUCP0Mz82szYDCtuycYQFCD3zT6X0nU3I9PCBL1TqexeUfFPAXZSaahtQIIatUg92LAJZaOJQ2wp3D7G+bUlvd+gaIS2cLTkZOQ6ZpT3DDxc54VZDdMlUoSN3ibDo273MMdYfWwf/GtFMH8oX5rAibsHjN0nQG9VDFH2VN+IfISW/pAJU7sTTXTzEYNqEY6XlyFV0HY/5wno0EsyFHi2+pMv6wIBMlhNIpWTq98DLxg18jY0+Bo/2I/ledi0WFO/3tx82OtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fj/Tt8Mh3R5X8jsO26m/jAV8kSDrOhsc8WjA+p6VIs=;
 b=PqK2cuUrLmtmizKNYDXBfpLfJqrG9C1g5oT9E80X/aRnYZEr8zIfJ9DFrc+dbkIhBOuqy6Kh1jirtC0pH413DdL7eHfymzw00fhRPVMHMVZlm9zcTCfrcZzEJKO1jtwRCRDecngDLDbysarJVtHhEb8sBVyXKA8r8NQ7b9HCtOWdhg5h7ZQ4sRz9rtPdDYRxqb6xzzT6Kl9Dw7ik0B8eaEYOFMjVDiOaFWWGbthhNpqvnoQdmlmFmT1DW+3PnvT5qXuIcqa/1zUs0zaWQtrtMFfZ7ICh7rhPrjLE2j8Fux9CLiMV6277D8kJQoOwUey3JohLMAOsXIzfDWSzs/wh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fj/Tt8Mh3R5X8jsO26m/jAV8kSDrOhsc8WjA+p6VIs=;
 b=KoK/s2aXv7/AYEfXRkU0kuU9prfx3+1shq6QjpgJKvB3hMs+RLfGK3bhG7e3qx33S0qTVdb1PGOxAx+nZ6DfGfqaw+GIrZBVKHK75+vMt5NshW0VJnq1hFMd8BH1CKZR3kYuknJClnCA0AapcQTiv6DXQRlB2bhAf8ZvxBY1dqzOJwEuc8EAu5265wyk1aZunvZ4oxj0ioxPkBTKadZaffukbNiqworY5HniLXKuXdBCuBgr9MPO96TQhqmTXuFdy2Xd96YvHxHxKs8TIxJ8bHPyqfmHcz8uvsuC81VaQMeIHBNFuddACBJap2TQObEX0ia7iaed379Nm6IkL5O1qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYUPR06MB5946.apcprd06.prod.outlook.com (2603:1096:400:347::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.10; Fri, 1 Nov
 2024 12:26:21 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%2]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 12:26:21 +0000
To: xiang@kernel.org
Subject: [PATCH] erofs: add sysfs node to control cached decompression strategy
Date: Fri,  1 Nov 2024 06:42:41 -0600
Message-Id: <20241101124241.3090642-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::17) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|TYUPR06MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd7cfa3-bb3d-40bb-c9a4-08dcfa7064f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?39NzYwGRs+nPBVP3koC70nX1p2nJ4/NHaWtHEu7xaQE9q3IuWxzRU8CxN5m3?=
 =?us-ascii?Q?bkhPn5xss3u6FH3k1/LR5bZh2oIyc6LsqnBavtynuej7qA+WtSVLRod9XR2F?=
 =?us-ascii?Q?7pIrSmwgRjtSC+cvsNHHg7+WE6kaD2Y7FFPoFOe5SKT6iZ9d3miY3bCLWX0K?=
 =?us-ascii?Q?fcjhdiQwz8d5og4/Zusq+8+ZDWlo52mrsC9/cKWlzE5DWkT8JDepRMEsJuUZ?=
 =?us-ascii?Q?sRsmEW98npyVV5PDzfX70TGPs0lr0/inKm/AODLQk2pUuEYRzAEhrpC1+UU6?=
 =?us-ascii?Q?oyyatde5uG2fbvufluzzESZ5X5hvRNP477/QY68SXDrGZZv7Sd9M6lrSdVop?=
 =?us-ascii?Q?k6K7hC4BiPxZAk7CEHRe7hk8EmS3upKsvLu/xT2DC/LmYVpL7lQD6l6lMsX6?=
 =?us-ascii?Q?DjVFilPDjSonsZBQyIgPM28ZTZol9K+p7bRxbF8kAdG4/ma/NaGHy2QnXYTk?=
 =?us-ascii?Q?jijdc3/OLrOikwjCa3d7AHL2tA+FvcIiY6dPdYEQyCXT4SMyuclPBqDsnu1H?=
 =?us-ascii?Q?ZRU21UOzhDHt5I4stu3jBL5WVjlFmwO+U1U6jmAHPfRLmEcTEgwswiFH2TV7?=
 =?us-ascii?Q?XeTa2LTRTCu4Ni6yiJ1odC/CEVqBfa5+HQh0MaJYqZkDKOEq44l2QzLtJMfv?=
 =?us-ascii?Q?uzpaMo/eZbVMDALgEqAvzyNgpcH5L3kxaJ4Gq6G+0Vfgy/bWfLbgIaoGiap6?=
 =?us-ascii?Q?04UDKoycWmyqdHnU/9Xtj/o8BCkAc+sD5rjWGfvnExVGrmMxKB6N9qsCdW7Q?=
 =?us-ascii?Q?FY41OFakkqdxZnNaOKTtqsu6CM1Dy7JPinidHhGvAwBiAn5a2hgwb/ghs/mT?=
 =?us-ascii?Q?a5aYH4fe1MmTdT77uyeoqu6xdZw0qH5Y5y8Tp8f8Irs4GzMG/qbkBIKlH5Re?=
 =?us-ascii?Q?HxiMP+udseE9JIqJJEQQsEsozCyt0eSJNlWQaHUxQ81bkwAGOSO27Jm0wGMe?=
 =?us-ascii?Q?pLabTV2eUauiXBztHhyGcItuaMpYJVXQg0/6BQWUXXCC2sbMd+vLx7U6HunS?=
 =?us-ascii?Q?2WBxZnCjX/60IAnqkxDDPeR0kelTBFHqA6ZZegBUGmYvxLGNw4wZENEpvdR5?=
 =?us-ascii?Q?PU5NfduLpIVAWhnAHKFAY9Z24C+A73EZw5KQMKsA6kNFCfNij6BNPtbwMAAt?=
 =?us-ascii?Q?17CJ7qvQEyIIymSxkotmAYdqFjXmo57+V5z3JfxTVHEJPV06cJcrXeZVh/2G?=
 =?us-ascii?Q?btgk91mK6rc6ebrxw2s3AO7C0mcfqlFUJT5owtdYjkXNXYJXnYhSZhuAI90G?=
 =?us-ascii?Q?V+QwkiK6VMHae+cE7CzhYBCH2fFhcDTnEiaI1L09GOMlbcfmufQPQq1v2rTi?=
 =?us-ascii?Q?9edfL3w3RQSAq2qrdMn87gpcoK2t97k5hJIHRKtVlht7o0XHNyGBdrry86CX?=
 =?us-ascii?Q?FlAtLe8=3D?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?zLLKKYYOnLlT73xyNxrDw6Z9z1z0VUy7rcQyhAWN4dTL4p63wuoynVz3sA0y?=
 =?us-ascii?Q?NAD4eV2LkgqgVyj8PjaE0zheqOG8fX7iQO9vKUcDxlqEQZzZ9JWU8yVycLjw?=
 =?us-ascii?Q?BJBlwXZgnugcJ943JRJ+ICPQxvEqBcn9/3gLJZRtwf0bdvDEh/IqpwZ42shd?=
 =?us-ascii?Q?ewTR4Zfrw4qiS+W3ppDGhKCqQVUJ7jjGMbI7gTePbLd/YlUTEJ8g2lbHFiCG?=
 =?us-ascii?Q?Y4lRkO4zk9C93s0B+ZNfkys6BdD9ncr+uiGR3aJoM6sPxQjYWvHGr4Yo3oQq?=
 =?us-ascii?Q?vIjR4owGsVrQZZpgU3qyUBRzgX99yp0gDrBds2wp5iAmTg9IP8SNUDIr7fZe?=
 =?us-ascii?Q?rhHNZ0UnygU0G5B4kP2cVajL6ouEJUrAbICjNSRV5j06NQltu9GmkxWRl+i+?=
 =?us-ascii?Q?DCeReFvy8GBvl5Ob9+nRCBm+ZTCTO5iTL9F6qNIz0aEmRHoFxQlZWoN3wGb5?=
 =?us-ascii?Q?5JIn9haR+d7vztZjgPNp8LHfBJ5UiES86prgzW49MLHTn/9/ww3WpQoJhbnb?=
 =?us-ascii?Q?HkT35zpERf2paQ0B2YJDcUaKODhdwZQoOfo29D1hEnh82xauF/2JnWyTcTO9?=
 =?us-ascii?Q?DmgpkuEtn0QwN0R05w1+eJJjldgpdue6CsQ2Wn+DsAvLy3GpLZnLYtnPWANH?=
 =?us-ascii?Q?WBaUib4cS4BZ16d8LkEwNavzaT6UQAVjgHdBpE62DXaz+8Aq2WDDk/q5oTqk?=
 =?us-ascii?Q?isu1Ou6gYvM2/L2ram6aq0e/74sFZ9jrjmF8BzVPyhtdrm7C/sHjXjpBWddk?=
 =?us-ascii?Q?ej/Tnx59h5MtfYK6zvWCHG5ZMB6kfSKKxGXKqdztLzbI/qSdykX0ZHRlVRzC?=
 =?us-ascii?Q?RCONDLBk8iXTN2tBEItyjpaczUT71D11skZ4Jfvf7iK1p+AjMsmuw3tECeBG?=
 =?us-ascii?Q?xSJu5BGMjnm07Z0Lu3mBcviJ+ouHw9KRArjnZlvFLzm0QGbsMcxL+NQ2xgYq?=
 =?us-ascii?Q?Xg6jfnxN90+Hy3CGIuU8t+TlIP/ryLSiKqTceLBCF9BeDs1+INVZ5enB9ZVY?=
 =?us-ascii?Q?viIU6VKx56R7sAqa7QpP8kl6vNYElbJKtSOQmsZASo/3blyAi4LHPVM++Qv+?=
 =?us-ascii?Q?BwlO8bmAN6Tix9f9x1R44lIWa9GRTjteKYD7Vu55NQON1lYFxCVmaP9POIXV?=
 =?us-ascii?Q?JgZe/a5Ccgm+3UUANqar5xGJeyD2kuNR8AEiSrH5gfN88RS90SKcXXQugkyJ?=
 =?us-ascii?Q?LvORdQh8GD2STlG0CUEdATuT2ojXk5Iyj5JLUgWSiGOUOvtxKrwbYshsW+qe?=
 =?us-ascii?Q?oW7lCyiYMPO9P75iUYTzxLFaI1GspOQE2cUtdeouJXJ5upD5WYGg02kKnBaS?=
 =?us-ascii?Q?eXgI/y+7/MNjoYoLR7QACpMuw9pUu/81kzK9HPKpd8Q/XBJOesfzKNjNWuJP?=
 =?us-ascii?Q?EqQK7iUPOCY7WBCsJGmzV9rRmeBa3dQLGHytwEHjbNfOa1XjrpAyCnSzfyRt?=
 =?us-ascii?Q?F3YT+gotrCVNdc+DmRiUySern95JXwcaiwFA7Rhqu5CQxZvHrLHt7VD0Wal4?=
 =?us-ascii?Q?RY33W9wf110vV2loqDgqX8VPeQIWhe8vTX/lFtZrTfjuCDOYeD8KzJ76PO8B?=
 =?us-ascii?Q?eWdKskUei710YdCYVU6VHVEDYJ56b+4HsYKbF73U?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd7cfa3-bb3d-40bb-c9a4-08dcfa7064f6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 12:26:21.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esuZWcKviexBX6og8K2d5fVudCfpE9p3kRckNyi0qLSauyGhHk1e6CudI3Lg84Wzx0y6Je2z/dyInDQl4W8Z6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5946
X-Spam-Status: No, score=-0.2 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
	SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Chunhai Guo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chunhai Guo <guochunhai@vivo.com>
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add sysfs node to control cached decompression strategy, and all the
cache will be cleaned up when the strategy is set to
EROFS_ZIP_CACHE_DISABLED.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 14 ++++++++++++++
 fs/erofs/sysfs.c                         |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 284224d1b56f..194087bcbaea 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -16,3 +16,17 @@ Description:	Control strategy of sync decompression:
 		  readahead on atomic contexts only.
 		- 1 (force on): enable for readpage and readahead.
 		- 2 (force off): disable for all situations.
+
+What:		/sys/fs/erofs/<disk>/cache_strategy
+Date:		November 2024
+Contact:	"Guo Chunhai" <guochunhai@vivo.com>
+Description:	Control strategy of cached decompression strategy
+
+		- 0 (disabled): In-place I/O decompression only.
+		- 1 (readahead): Cache the last incomplete compressed physical
+			cluster for further reading. It still does in-place I/O
+			decompression for the rest compressed physical clusters.
+		- 2 (default, readaround): Cache the both ends of incomplete
+			compressed physical clusters for further reading. It
+			still does in-place I/O decompression for the rest
+			compressed physical clusters.
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 63cffd0fd261..2ee59eef3aa7 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -57,11 +57,13 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #ifdef CONFIG_EROFS_FS_ZIP
 EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+EROFS_ATTR_RW_UI(cache_strategy, erofs_mount_opts);
 #endif
 
 static struct attribute *erofs_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
+	ATTR_LIST(cache_strategy),
 #endif
 	NULL,
 };
@@ -150,6 +152,12 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 		if (!strcmp(a->attr.name, "sync_decompress") &&
 		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
 			return -EINVAL;
+		else if (!strcmp(a->attr.name, "cache_strategy")) {
+			if (t > EROFS_ZIP_CACHE_READAROUND)
+				return -EINVAL;
+			else if (t == EROFS_ZIP_CACHE_DISABLED)
+				z_erofs_shrink_scan(sbi, ~0UL);
+		}
 #endif
 		*(unsigned int *)ptr = t;
 		return len;
-- 
2.25.1

