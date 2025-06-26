Return-Path: <linux-erofs+bounces-494-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBDAE939B
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Jun 2025 03:15:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSLN05hk1z2xRq;
	Thu, 26 Jun 2025 11:15:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c408::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750900528;
	cv=pass; b=bcsaIVWB184cbyp7kMH2cCPIuVVxRMH9Q/iyp9qqVZkL/6h8m6QK5bX8aloyoznq3HUs2HMrUXJ+Eky/h5g3OfC+BLmG56VsTIoXy9XR4dUNeIvACqLiuMuvQKA5hfAyoFPy/zQW6UAmYTZNqPG4oAw40lcmHdLrAu1w4qTBs8KCecURL7zxdg/gmFMIBowUTNMNR7oWD1wGwv1yZiuou3j561+ffCtcZR8+vFrXd56+LSCW0Aw956lummp8PoddD+hF48H/EBqKAi//2VN23SC4WhuiWS83rVGBYmFG3Jzpx6EOhhYw/vvcqWzu9I10Y1SLZGvEMSzwhpj0DgI0fw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750900528; c=relaxed/relaxed;
	bh=FOYC1KwNTlDghiVyfjCyQDb7+832dDxYteIjQCOnVlg=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=iXqMlN1v19MrPmKR5qJ+mep0PjZ61cqFwreYN8HgR+Pi1/wcEcy6tGMJIq7J1TBXlQXpl2bt6ZFQn1qwWW6C9iAP81Ajr/szLGvheOiSbpg/9jQrHM/+UZ5reEEXRZpAeY2LKnfuSxoK0xS1Ompz7QrIY4LjJzmkJsmt7FQHq6x3pIZq50RybVKu5NqNBTDalC2jB9kh+8naqalVBitlDM81ZEvtlNU2tLzhVMKQfasjCrxpb3KaTsif9xERjUe6cu208hde+olw0s01AKRBxqV0cVp9hSbAyR8VjPcBRFelpwOWl2fYeWAmIUyOLqr+9sEHPE9uJMz/NmuJOpqtZw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dataacquire.org; spf=pass (client-ip=2a01:111:f403:c408::3; helo=pnzpr01cu001.outbound.protection.outlook.com; envelope-from=jerry.rose@dataacquire.org; receiver=lists.ozlabs.org) smtp.mailfrom=dataacquire.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dataacquire.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=dataacquire.org (client-ip=2a01:111:f403:c408::3; helo=pnzpr01cu001.outbound.protection.outlook.com; envelope-from=jerry.rose@dataacquire.org; receiver=lists.ozlabs.org)
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSLMy29Y8z2xKh
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Jun 2025 11:15:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quIsO4TBDsD0LyF4Zt8UKT1UgiReeFlMpBYkg3uJgrm+k4qCZj5cZm2TYKjCpKJZCdV//MaWrLwCYHY/c7Sd4CP27IhqNCdfubaCj4Ygu44fWAzBupY2pBw54vrYma98Klr5d/W8/Rn65vKVZwA0XeTS4nkmuJCx3977cR1bgYaT9RcUqGGx6QCeUdbnhQ35z8jwBlM+Ye5Fm6TPDRaJHnHxgLHcwKUSFk/NasJ1P296r37HXqPvrzqy8INt+mXKjzBar1NcpQ+CNAiiLjBLChcqs87zKPnwjR3ZYkI8+/ulD4c8U/wEnS90KYH3eE8gTjoDv1E+UIEojvd5c0zx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOYC1KwNTlDghiVyfjCyQDb7+832dDxYteIjQCOnVlg=;
 b=SOHLQu8BbhZD3aaWgu54fDP6pbG9bWtgBZjOv1XLfQP19FMSuSaC9dKuQQhNfdseXINgeXY9IQI/w1xw7zA1JO9IvMJmmBaikUHKnyUuvKTsiz9+ReJgXWqa5umpkngZCzvJPHxicF0FfrrYd7jGDxHfoCj7OAtwdchi1FrDl1qf5gVyn+9RpCeS6kO/zrhaXHt92BfxeppOfPE139UjvEVyhcA1EMO+mOr+97+kt3TB77H3niFZBe8XJ6Y5+lXoVW2tQ6YG1uLM2dzlZh86raCM/JyVK/gYbMEf1tUE3pQeFqZR3OwKYkTtP+ICNqcUOrCDd3lDha3ft+RqNrTGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dataacquire.org; dmarc=pass action=none
 header.from=dataacquire.org; dkim=pass header.d=dataacquire.org; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dataacquire.org;
Received: from MA0P287MB0514.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c8::7) by
 PNXP287MB4161.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:290::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Thu, 26 Jun 2025 01:15:01 +0000
Received: from MA0P287MB0514.INDP287.PROD.OUTLOOK.COM
 ([fe80::e43b:e247:46d0:bf13]) by MA0P287MB0514.INDP287.PROD.OUTLOOK.COM
 ([fe80::e43b:e247:46d0:bf13%2]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 01:15:01 +0000
Content-Type: multipart/mixed; boundary="===============7510618287562264198=="
From: jerry rose <jerry.rose@dataacquire.org>
To: linux-erofs@lists.ozlabs.org
Subject: LIBRAMONT - Agriculture/Forestry 2025
Date: Thu, 26 Jun 2025 01:14:59 +0000
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To MA0P287MB0514.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:c8::7)
Message-ID:
 <MA0P287MB0514DDA2DD9791FFB1E6E71F957AA@MA0P287MB0514.INDP287.PROD.OUTLOOK.COM>
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
X-MS-TrafficTypeDiagnostic: MA0P287MB0514:EE_|PNXP287MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: d834221f-b4d4-42cf-6952-08ddb44edfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|10070799003|376014|8096899003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vJqHUzjxM8cGZQ5xalLLBSrLW1mDwviiMJDEg4VGykkJRWW9IQ2ow/0Df52C?=
 =?us-ascii?Q?D1eFUhXr6t2P5A9yPTshEZGjR78bKDGjWQ9DX4l9XhI+PIscoDPPlCFTyAIw?=
 =?us-ascii?Q?a4p7ceWZdftP9qZ90L3ha0vqibrHPhqqEsRV1iyb2zD9aTnmFY7rbTrPqywh?=
 =?us-ascii?Q?sXzjC08toqFnSEoUUKIzfuqPmd/9HYnNfYk6h8vAe+KyaPcm/hbtLiFQCHt7?=
 =?us-ascii?Q?GviOr5l999fiUWXN+nfY0MHmmovxygeyvWrANYWXRbHZ2+kZp67C0Qe3fX1Y?=
 =?us-ascii?Q?oCpVnb82vvUgWRcagALb4+erfojO4VnpVGM4eAvHAI0P1Pz2pZomOKTmADPG?=
 =?us-ascii?Q?Ah05bkJ/C4305GG3gsI3y04ZsQRbwABXT7RWFvPQydWXIkog9OK1X2co/Td4?=
 =?us-ascii?Q?Q96cvdukoiHtX3s+dBtg0w75zVRUIShSEjL4T8Qux1+X0gLv78RbpI20jSxW?=
 =?us-ascii?Q?17W/o28SXRMpV48QeVj3FY/nihOiuegjX97d66X+Ag+vaUpziASD/Uy5mx2d?=
 =?us-ascii?Q?gtsx3GonN2fy9mE+tTefgo6+OKc9OXnVxIo3r56eAE8k4pVvG2gIxuuM01gp?=
 =?us-ascii?Q?hLotc1P8jMRUXyHynvPhMDv3CbSzcC1bg7qe/ACkCcDIdzRMEuqK3rd/++7U?=
 =?us-ascii?Q?gXWtMNCPaiOfwliItJDA8T858FYxy2it1TAHRG7NE0AcCVqUolPL2Vw4X2al?=
 =?us-ascii?Q?55TrzR4nwlFOS+u2aLRAUiCtkUlmESxZO5CgvVjBsNF5KroB2uo25liE1Cy4?=
 =?us-ascii?Q?ndM7s5w6J1Wd1jRzMqI1mk5V5lpLrdggoHhusW4lPKNw9/t+zfUEGGVvQV1E?=
 =?us-ascii?Q?nJwPp0pBT22WW/zIzFolqpn+Bfb8SGTf9WQOlUvhjraEInpsld0Y+oJNuZHF?=
 =?us-ascii?Q?igJwjgYCCWiH45UEUwy+WBzcpHfXPloqAi0H7rFYYHeUAg0C7hvcEcpEhgDn?=
 =?us-ascii?Q?vSIoyvNuOG3IrFF1lkBIdZJ+rq+UALW8KMaJy0G+7G89MEGjOOdcP+8yQIsD?=
 =?us-ascii?Q?aTbCh5y559Fzht4V1cy2WksN57gFGYoJxzFghc6aVrMTqFAAKgLW46q4ED+t?=
 =?us-ascii?Q?SrotMI7sXM5j2mbBW2ntlpq1vGTfkc6/xhWvpOqqAJggqzIXKVXtlT1cHwVE?=
 =?us-ascii?Q?oE8OH40rOhXTeuJs4HDa0r5C3MSXuJlum/LCR3LVDXmlfEdBaxo0ppNsBp7i?=
 =?us-ascii?Q?AfHXks2XXEB5HhQR2KGljQl55yCnlVle6sztfe/6WqJzX+QUQxHEXu0vWRLh?=
 =?us-ascii?Q?kRLj0VwUoYFt5XbMBcl9fPFShR3aKdbfNzDe0Q2pI0vfhW+T7KSX5N4jTLLn?=
 =?us-ascii?Q?fyzh0XnqVJBfO+HeAyh6sAICSHB6WOmce/9I3vxC6EY0Pkzm6V5Ryn+IwCYD?=
 =?us-ascii?Q?/PEGiGq9MZ5l+xRCfrJagVBXsEJRcK6xdunJYS+Uwm19IL1Rhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB0514.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(10070799003)(376014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzkE+HfwvKnQB0V/ARfEzR9ycMNbviWjw75A+FsqJAtj8EyvzhmgCgg2hjXR?=
 =?us-ascii?Q?j8BMJD+5MihgJVHVpvAGeAoepUif4UAkTWaoPEkw4YPQVhqZEzbAEnEt5XHm?=
 =?us-ascii?Q?G+b41tOURyWbyAic5KAixk6CeLcO6uJnNIxyOpLp1eLEjVdgBrYZ4FZz+THD?=
 =?us-ascii?Q?VL2jl+s0wUadNlI3iuDL3YO5+TECOZBBnuOqbygupPwBs/u8ayGNYSbDMRWR?=
 =?us-ascii?Q?4s1Kkn5rRMR6n4NjnJ6u9iTDlMMFqjRmGze5cB+RlhidAPeJfTDH3aRpB2cJ?=
 =?us-ascii?Q?rQboT2g8HosOLILC1jFOGIa5x2UQw+iDo4RK1PP4+ZavTL8JrhNNDssIBRkO?=
 =?us-ascii?Q?YsK0nALyvLSUJ+NiJn9TNHb0jFb6L2FoQJmfTMQxjGEnjaFe9Zu046iqUIMS?=
 =?us-ascii?Q?d4FVp+6WQMvO6orThAF/5rawr08vkhFSB0on3wIR4sIYYaWHombHvqb4a74M?=
 =?us-ascii?Q?S5CXk1YdeH5s3VrGU4UhhNBuPsf3HTMmuAcUWilYfXmj0B2BqLnds09SzM/z?=
 =?us-ascii?Q?Vy7mZIqMio3G7Lv+UzUc8jK2HHmzOTExyvtpN0ArE7MASoy3x3gccNm8eb18?=
 =?us-ascii?Q?/YMLbEoscYooFNPAqp+8tT3LZMqgUykEhu4pEi5gfOdmCG/PhgsfzGv9S5qN?=
 =?us-ascii?Q?SelSGTXDdywrJDbytDXs0s2SBjPeb0CL9zbWb97sHpQQGnPtRWAGKBo56E8J?=
 =?us-ascii?Q?jAYVcGywLwjerxJTzKieL/zJu5EfPAonRZvwTayHXpdAsnCr/4wZO+c1hcMw?=
 =?us-ascii?Q?N0MIfnjZ8Vx8HDHTVGgxfke/hAGoT16t2LuPZCehdYUUeq4UOhl0yZ+l2aGS?=
 =?us-ascii?Q?Mr/gZQSHVfrWcZEN41c/ykjCPjKQjQxKS03MuWuN37LxYeVe05j0raZ0VIxS?=
 =?us-ascii?Q?8njESoqNadRtXmvT+tDMlQrBnAiFcafbL7I2zibW24SMC5Yz8KzIto0b8h+t?=
 =?us-ascii?Q?5MIf+Og6m9l+gobXqLKsjFYH5uPSz38GJkj1WIIB6y92YLvlbVjxxWQUxDqJ?=
 =?us-ascii?Q?pAG9I78gPUXgGS/UUQ9bTV//QyZJEzvqSJE/dWgcROPBhLNdsdQN1zLcfDpA?=
 =?us-ascii?Q?80x2p4uDcR4ffyisW0jmZ15pRDlKC+BppUATNlMk+lxHeSP+vOkqn3FkAot2?=
 =?us-ascii?Q?Grq/zInbsoCKpeDdkzVUhFx3XPk+U3MlsIGVrRcaHSVQI7MDj9we0dPqlwan?=
 =?us-ascii?Q?27oVJTb0RxCeLfcaHjbYU2Pxcj/QKXKvnKiSIQ6UpKCnSI5Q8rpq332p4As1?=
 =?us-ascii?Q?tYjFeYLLwNsIMLf5/XUA1JXOOSw3P/jmxZ8n6RGMNF9PQUbHsfoRqWd0Cyk8?=
 =?us-ascii?Q?bCkMQHR/8zoBxuiIu2MQHKi9lM+jiE33Jo5f9FmaZQjBHqQKcZfdoNzAas65?=
 =?us-ascii?Q?z4v6qp/cYpKdhGVvOOHvfUv1ZNuYoHVDghVoi+OLG1b8kRxxi//xFmSJPVls?=
 =?us-ascii?Q?zj11uI+SckwMAUraL26hZZR9ym06/bINZB+93ZC9xCTGZ8+aMy29X9iRI4h7?=
 =?us-ascii?Q?ZYRQwRaV+6o2D+2URfsLUxMtGt/H9Oe6TgXYPlnXXkU09h84nMBSS2drlncB?=
 =?us-ascii?Q?+JQL74+ImMrq/nsfdX43Y4Hnrd1DrQ9Geg0NjMIpGj+SmCWM+Aj7WyKrJqD0?=
 =?us-ascii?Q?eWWXI/x9FRBkNO9J9+JLaGE=3D?=
X-OriginatorOrg: dataacquire.org
X-MS-Exchange-CrossTenant-Network-Message-Id: d834221f-b4d4-42cf-6952-08ddb44edfa0
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0514.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 01:15:01.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c60bf858-9bed-4435-9799-4bbd780a983b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTHtBmUUcmjZq2k5hz7EiqpBHDDloO6fc7lFoQ+QNcdcHW4VI0jhlwECL5XWHNeU1X2avb/qJQREwOIYsWWJcoYGV++Q8lQLCbtyhOoRU4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB4161
X-Spam-Status: No, score=0.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	FILL_THIS_FORM,HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MIME_HTML_ONLY,
	RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_LONG
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--===============7510618287562264198==
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: 7bit

<meta http-equiv="Content-Type" content="text/html; charset=us-ascii">Hi,<br><br>I am following up to see if you are interested in receiving the attendees list for the LIBRAMONT - Agriculture/Forestry 2025. If so, I can provide further details, including the Cost number of Contacts and other relevant information.<br><br>Each Contact Includes: Business Name, Contact Name, Job Title, Email Address, Phone Number, Web Address, Mailing Address/Physical Address, Country, City, State and Zip Code.<br><br>Thank you and look forward to hearing from you.<br><br>Thanks &amp; Regards,<br>jerry rose<br>Marketing Manager<br>
--===============7510618287562264198==--

