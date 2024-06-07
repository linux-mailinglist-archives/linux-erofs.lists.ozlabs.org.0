Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07B900A98
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Jun 2024 18:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1717778345;
	bh=zpyb7zbW9dmlwOXuqfyjI0uCQEEVitDrcdUholcQfoc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=L8DFb6NJ+smFxjtVrvyMpK0OjIaUsBLH6c3rzPk5ApuTTirD/8ELwNF5LV05j5DG5
	 0eYTZoPCXdh5dQQg/cTzKGIp1M6pxeMUFpDkNGhpFs+Pi655YNNCE+kWJLqj/UC9IA
	 41WrcELEA3qFHxUUncg0Ag9OvCD++if7oSPTscWp1t3mrhry0SS+f6HXFBxa8nKCxD
	 yWDO/ukqKWoSFpyb/mUSDUAukQQ81sD/I4HMfoAIaNex09Pmh4J3k7MnByxDzwtzkc
	 2YT4nMFI4au2+DkM8V804JO/qZr74osBO3MFhvHksqwyFimhsheo0jJR0zpZViFFJh
	 MpoPAjs9OL5EQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vwn2w6qsqz3cPl
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Jun 2024 02:39:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=TaMnLgnL;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=eUxEImMU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=john.g.garry@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vwn2p09jYz30Ss
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Jun 2024 02:38:56 +1000 (AEST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuUEw023598;
	Fri, 7 Jun 2024 14:40:34 GMT
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrsdq2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DL9rL025127;
	Fri, 7 Jun 2024 14:40:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtd30cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVrroKyUtwa+qWmsCnz847ctGsLTgm12Xqgp8upDauxhg7Obi2EAEZwRw95ANpFQBhRNhmVeHZ/I9MASj3YN17rIbMmHQMwbzDj8QME75Q+V7uJPxx830LJdvsi56DKiJM1G7LXgnSRiYHEZ3DltGyagwAfS53vO24f7w4BCDIovPWfH3aHkipRDomfIUnUCpp/Xbc/jFIP8oYJsyQJwa4/vFLS3m2D3tjI0Pwp7pEeZrA5ZRv6TASHHdG7bmuSWS1Hyx+MgqePWJ3CaVii9zTnE55NEYqCRpTikoRPUVBhMLKmAUzvoCloqzwa1A1w2iXBQEhHdiBDxdQSPn0Kx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpyb7zbW9dmlwOXuqfyjI0uCQEEVitDrcdUholcQfoc=;
 b=MJA2Bef8xvwHWEhmErx3W2caAdVZtj60cNFt7hTsY3hUF9wWH9air4Q4aw0XwQzWaoVBGctQuBgJZ5m7QZHRYezmsWp0Bff64lmW0Nft1JtU+zvyCsCT7NIPM+hA2kYlSsTW+xdnbEtkpaGpqAzeLDLnWb+gyUgQm7U5ci0TtV+oUWRhWRHqozIT8Bz762QShKC3ERpYL+YIsnLAtO7Q+sSiZNDZ3o388KVpMXeimQR1dLHdek6/88Ms5hiMDSksjYrCNXP5G3mfVHqHMWg+6Vqa1bz++dZlzIX93t9k6jEKMGvrv0564avmsAGcRTasdKF8vjI9CmIK0AyGzoPWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:31 +0000
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Subject: [PATCH v4 15/22] xfs: Don't revert allocated offset for forcealign
Date: Fri,  7 Jun 2024 14:39:12 +0000
Message-Id: <20240607143919.2622319-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: fa050bea-877b-4cba-1e7d-08dc86ffc816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 	=?us-ascii?Q?rqENboK61cG06EC3TLOxBe9a0XcGyqAu3PX+06tRxCC5Efs4oXzErjfMeA7g?=
 =?us-ascii?Q?rUlKnLXOBvTL/Sruws67on8OgOEmhUZPqYZx19+nfsgce6bt2JOYkiGSG0Ai?=
 =?us-ascii?Q?8coNP8PzNrhAt+v3vQS4vhSumuWqYtrZRjbLQOG+AfVhesxLQ136WCGxkvrM?=
 =?us-ascii?Q?t2KuORxYREkcHuF3NWM51OrnUU7aK68J1Y19bjCk9MlJbtk28rVWeJXnCeR9?=
 =?us-ascii?Q?Umz2b/1KB1e7hkikqqZZK1ntLXsVFm1Yvnl53SCYSINgRM/2MqYNYMlmY5Ss?=
 =?us-ascii?Q?1j0zpWR2KGp5O33iYKwCC+62lvBl8vC3RK35qoYz9qqjb98gedIL2sEbRX5a?=
 =?us-ascii?Q?RDQUhkl6ZLhloZVFm4wlbKQeYpMsjE/3K5w4pFha0Aj/otDNvZjUKNVgLN+f?=
 =?us-ascii?Q?ii52fZwVdr7lOVNuCrNv3YH6KjyUm34Voa64Z0rrxhf7vIS05esG3gr6ZNT+?=
 =?us-ascii?Q?uEvhWJ0IIj+DBvM5EXN+SpG7gsU7cY9YY2aKcfOK+/hAGU5Yqf6xidvewnWe?=
 =?us-ascii?Q?omrN9DsAW30in0fnkc+eOp0pNVrYBbozli5Lcur8mTuovipMEK2NekT0UpIM?=
 =?us-ascii?Q?ygDkSX1BDr4CdAsC54aDl+hmZKk9E9BLUDoi7gN2EaXaP0I2oIHNcmMsNv7K?=
 =?us-ascii?Q?/sTcjM6QZFAEeNY85wr9ljxEEdsCy2E0bTqTgNUGzIZyQEiMyAFxIAKvq7yY?=
 =?us-ascii?Q?AD5wp12snYCHVDZI+MusQvzhBYkAq4TL9s8i92LFQk0+DAOExltig01Alc5G?=
 =?us-ascii?Q?lO19pDFNRYOVsg9ASIhwYJ0N5Cf6l/1raXTQTM3cjbKM9B1qsD0pKz6r7Kfl?=
 =?us-ascii?Q?OpBTKvsOnMJ4s5Lxsm3T6ikWIby/o33e6naM7oPfUh+5bbsNfE26E9FTSIV+?=
 =?us-ascii?Q?Dl7FSp35YO6c0hGAvOHixzCq+TIMbsw58OCzgiPhKmSz4brmTkEjoJOYTyZP?=
 =?us-ascii?Q?RMC6n2bEHuJrBMx1GDVnuQGT2T59nVwsJ8OdLLczfheYcp4hYsX5inMhnUjR?=
 =?us-ascii?Q?2QR1OZsiJKNltFzX56eT8UFafhe/SqFMohpbUMAV0EzyPku3BjoEXYHoeSgl?=
 =?us-ascii?Q?mmaI7SqLmfC704mUsH6Vbifl1lVxu7QOxGI5sshsKUInDBas7AK41gv4HJc+?=
 =?us-ascii?Q?acEjGXK+ibTjUsG8Eezon6Ex1c4bEnFOjeLNRPPkbXnpbI52SnTcuUeSfuW9?=
 =?us-ascii?Q?XTZBH4CJNo0oYWbolc6PcdGDspwwUVdNbd8YUIPqYLERoi7xNblrSe0LyHya?=
 =?us-ascii?Q?FKb+HfNiZdbSluXcGPvM/5hu1Oez5UlgBK0dR+/KnFQ7uQOyg2Rf24Kl8oyD?=
 =?us-ascii?Q?AIGCn7DxO4F0bWgSNJwoNZ6d?=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?3Qrf/N71SUgdqetXjAIiIYWiPkzDPbeG57Gfopl/r/cmFtfuJ0+y2ThdzkcJ?=
 =?us-ascii?Q?QbXLfRgJkrQYN4INcUmNmxOiiNQy0HNyLaikPbKwlNZSYcSuo5QJpme953pA?=
 =?us-ascii?Q?5MdyfieDtswALblrurGOUwlcblMKCpvJFb7i4r7zKc4c12RuCKVHYtLMVmff?=
 =?us-ascii?Q?Q+qlOXcZIcjIJR6wEU6peWT9rhbgXv51arLBABCDTD2Y7nOa7f6/sJnsEHZX?=
 =?us-ascii?Q?hHF82GNY4gho9piNTZ07yPyuL79f+NmOMdJ5K7gJygFF7I4fobK7KzTlVlME?=
 =?us-ascii?Q?U2hVoOQ7YB0XPoZLYl3oOlw4fxC+fEXI2NXvyOcbdgPDxZDFwzkneiSIh/ht?=
 =?us-ascii?Q?GKqYq1+f1LNNHL6yjEldEArSj+zzBVnDaViBY2nfXRqpeM3nR/q148owGY6c?=
 =?us-ascii?Q?H7fmIWI14q6yqQ9l5MGM+HPcDzt1V+ZKaPXN8hA3yBDz1uAUhPsQUbRhEhAx?=
 =?us-ascii?Q?ATPFKnkc6Ykc9aW2wumzGhuK2MKPmTzfihn/ENtAgJrFM/fSejU5sY+FifC1?=
 =?us-ascii?Q?TPJszqEBFnP+UR0jZb/hC/gPLT1VG9PPevETLSzSFfsSNFSkp8mophvQrFDq?=
 =?us-ascii?Q?gYeThbul18OWcUHibS2bNhC5u5HwCdYfwFukLXjdJ0/2ovTLHodwSijJbslz?=
 =?us-ascii?Q?vv94RZBiS3sl6zb0vDVNAE1yrhqRwOwkSkRHw7CsrNwSRZ+gdohNXeX0pxOZ?=
 =?us-ascii?Q?mUvBYVn1TDawalB6rOUpTKykGdMEMTrY/ZxHjZBbvvm/gJAIlS3h7lBFBDUM?=
 =?us-ascii?Q?dZ7skIeitsYhr/Otgz9fFyKP6dUppkpkOIq2hU1MoHsTpmkdqXZmujqshea3?=
 =?us-ascii?Q?AmgDAvKWwqc6pBCTRZLGAi/T/cwTKWM4tRJs5pXN0UyPDmeIFDDHdVMeTAjn?=
 =?us-ascii?Q?rfQaSumayU1eEdW09OMdUgWLS4PLnpMYqEee7s00BOks9QRyYEeao13wQBqk?=
 =?us-ascii?Q?w0AZ+xFaYM1MueAGr7RWnETlqIJjg9d+oOvJUxJaCVHPNM4wYk88VlSFJ3i8?=
 =?us-ascii?Q?BJC0+pK81C/e881YyxV86seaQ8HVh9lrmjWJcitrSH6zWayut4ECdaJJWJjf?=
 =?us-ascii?Q?qZaBgyRtaoExkHJMXQqsU3Z0uk3xRFZTl/+ljUcurul+HdW0Ru/7IGI5Wurm?=
 =?us-ascii?Q?HA3lkCj+6MX/kg/s04sS50fW8lfC1N2KgnJ/ggVTVjqytB4E/QemBeDqI5Ep?=
 =?us-ascii?Q?11FAi41Gt+54fBj0k5tutSuAtZvBdFm9/BkPDozR+KxaU8JOnU6+3hYe2Hhn?=
 =?us-ascii?Q?VMcVXVoUmhONTmsv7yNubdBbuKgxvbC7E0z0XTxeYyB0Qp5hXbDcDBHV4/A0?=
 =?us-ascii?Q?C0/amkfKHYObrv+N2a3pIlTJlijJkSE5PXscal3Va6gyZypH3g6/xiR0pZo0?=
 =?us-ascii?Q?4Skko2V8+giSFlZHgMiOil1s9IO0KzHsNpuWOLLRYjy3+8BI4UY6iLw9ZNG1?=
 =?us-ascii?Q?uxVH+u7pqM7+RW4ZQ1ftPuTexRjN8UVoRmwAlQSs6uscyTOm9puekgLI/Yno?=
 =?us-ascii?Q?5EObZg3TlbkreWDEOvm4qYtST1IOrk3r0o9tGHuMBc4dmuZyZbU+CUP1x3Kd?=
 =?us-ascii?Q?h7lsKe3Q5V6qu2efbRWffwwRQPCsCtwKZt22sQxlgIxU8XXRty0c9NEtD57F?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	kATONYSyBQWixwtt5cFhTHwJxLlK+MC4HNdTsOrSA0CKqf9nyhfzKn1Slr8ELUKaafcZrfrGuY+0Jhf8CG1niw5/sbnuCC3tOmOwbjw/RilQ5P1ndt9ZkQYtJyNLw6SleplVATeNBd4zmvSjUmmdevWZvaGVVDe4tx5z6JcHwnJsYsUXjayO8xSxkKm+Z66iNp30A7q0JheWPo3FsI9HtYs3Y25SbwKnJQeknrCb0JWW47QRVZjfff7PIJyQbjExxrvN+wr6evCc+0OBdw+nrobcHNMMPTq4J94bsXMFig9BK82UYmQAPZ0tOA28lzJhkj/hcgdXmbPwkhj6LR3iUUw4fqOyif2DalSIK8aylb9OXVGFT43jio/J8LWaQLQX24eZIzLrLgA84kR9jRcgdApDwgxQZTnY2UWVbB9ABWRBraMaehMNsppzziRZeH8X3O1cgGTyROoq5JiPclakcOWoLPh6HEol1HuEU9P9YvUUesIbsjaOaArDWuNPGoYRDAAiI42baFqIZ6224w431j1Pq0dnZbtrDwT7QlVNhYG4cGM5tvYyGqMwe9hY+0k/bT4EFRRDLcYfJK4J0mlVUszK1GWeJMRmj+5YL5GIcBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa050bea-877b-4cba-1e7d-08dc86ffc816
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:31.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y8Gp8DVusJyRPEn6H0nABxyx2dDQ9ljKrzLxIGmG+Je9sVU7+pCxniMa84meBDsnLZBd1aA+pECzEQ1VxGQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: d6wF1pdK0pg6X0esJ1uhhP6QxOFp4xz6
X-Proofpoint-GUID: d6wF1pdK0pg6X0esJ1uhhP6QxOFp4xz6
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
From: John Garry via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: John Garry <john.g.garry@oracle.com>
Cc: gfs2@lists.linux.dev, catherine.hoang@oracle.com, agruenba@redhat.com, martin.petersen@oracle.com, ritesh.list@gmail.com, miklos@szeredi.hu, John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, mcgrof@kernel.org, mikulas@artax.karlin.mff.cuni.cz, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In xfs_bmap_process_allocated_extent(), for when we found that we could not
provide the requested length completely, the mapping is moved so that we
can provide as much as possible for the original request.

For forcealign, this would mean ignoring alignment guaranteed, so don't do
this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 2b6d5ebd8b4f..b3552cb5fc8f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3492,11 +3492,15 @@ xfs_bmap_process_allocated_extent(
 	 * original request as possible.  Free space is apparently
 	 * very fragmented so we're unlikely to be able to satisfy the
 	 * hints anyway.
+	 * However, for an inode with forcealign, continue with the
+	 * found offset as we need to honour the alignment hint.
 	 */
-	if (ap->length <= orig_length)
-		ap->offset = orig_offset;
-	else if (ap->offset + ap->length < orig_offset + orig_length)
-		ap->offset = orig_offset + orig_length - ap->length;
+	if (!xfs_inode_has_forcealign(ap->ip)) {
+		if (ap->length <= orig_length)
+			ap->offset = orig_offset;
+		else if (ap->offset + ap->length < orig_offset + orig_length)
+			ap->offset = orig_offset + orig_length - ap->length;
+	}
 	xfs_bmap_alloc_account(ap);
 }
 
-- 
2.31.1

