Return-Path: <linux-erofs+bounces-2181-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGpeC4NLcmnpfAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2181-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 17:08:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78E699C9
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 17:08:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxmFX0JH3z309C;
	Fri, 23 Jan 2026 03:08:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.165.32 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769098112;
	cv=pass; b=GHUI3afk9tGDnBGFos4Hr5UbS/KIkwbgT2rQ/oxmyIGxUgJL/7KBKEbgIpLAZI6mEUxYGu1AYeItIbWoauX2rnu9IzbGugdjTswIlTsFHZ9koA1pmiJ1Xw0AxTAl/Cbl5p3V5eXmILifXwguHa0k2YsWULTVLteKOLAIKypS67XvHbGXTN5l8RLMZJRdkYBuAiKNW7h1TjrMOaOPs2Zliq3PgAX0ITB4cKr4TbpCHbOUUt+CigHQqpdlJejqq0lskdN4Qy4+QkP0SUwd6f6HOhsNG2fWZnUPcellEjb2p+Sk8TPKHLNvNrTkB3Wq5DnhibsKp8L21n1xD1LYw1LiCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769098112; c=relaxed/relaxed;
	bh=s9Q3bmmX0Y0SVFXEdXQ5FOtVISY7aFrN9t8eFSxHDRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfsYy4G4KDX9FtYOxP7Y0CRmDZfLpEYobI9dReF7/WvndKftO/Ug1UD6+dtb/66Z4WOFs40vbbOzp6OrAfVnkhd5Sa9Tu5TXVtSeAehPEsTQjaEOPBfyuyeol/O4PJ9dV19k9ZElxdEbsDT/k+PqKwnRVECwr6KNT7U0N+2a2o13vL46BEwkZo+7++HHSUCoW3E4HmFlwS0sAnG+Wh0/r15hQAEfwQFQOt4yAvIJeIZUMB4ZA/mdU7aSZUA9V2dYP+JgOio/9gDvFKGs7/0gqkAolsNJLetE8jj/OrefaZe3/JuW/BlsB3e+ABFZUV/QYdL2DTjD7405ub0K+EugJw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Gk7+qaV7; dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=A5H1PXRq; dkim-atps=neutral; spf=pass (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com; receiver=lists.ozlabs.org) smtp.mailfrom=oracle.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Gk7+qaV7;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=A5H1PXRq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxmFW2mpyz2yql
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 03:08:31 +1100 (AEDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDgI75197742;
	Thu, 22 Jan 2026 16:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s9Q3bmmX0Y0SVFXEdXQ5FOtVISY7aFrN9t8eFSxHDRI=; b=
	Gk7+qaV7j6MnDnwXDtLg37Jmf+778XoyTaYn8JJ8ESeoD39zUsDcWVFUVN/M1RkW
	4KEIPoGIfbbOMDmqA8NuqfqN006QyBRl+CGKoQ1JVUCxwYD8K6RTIpX3ncXmBKbS
	lvIfoIm5FcSjt/cjuRgOFyJ/zfKQ2Ns5qmSamSUW7s75q4ZJhK5g4lZo+uftmrOo
	6LpO1YQBGJ5ZG63NywFhwM1jIcauWwmCC9aGVix7a+KOIdDk/5LjpFlFj+GJs8qw
	7esoDUNi5rlzgp8q6gcNazAonwSFBhMiLxo0HLJCrqSweEmxJQnB8gtllaO2oN+z
	cTIpi2Ok8YHTA8vP9d0a8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypyvmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MEgcCN032257;
	Thu, 22 Jan 2026 16:06:51 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgusre-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 16:06:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmsGrg0x6uSaMfvsyq2giXXeeuLlI1ITVTNoEkL6ay/420RvKCTWWZN38unihrqFBPtb4U+pYK2gJOi66pb4xpmAIK83hWhBRz6ANrVYsugw23hYJhJjynfXtYKHta7Tg/IVha+IIHPDjt2LR1TOmc5k667xwy676ngurk7q9srrFwOOJcQjv6lrwh5yt5IalMXXvDCd4aeKqyndVrZF2Y2Gsiasw2gXfx9NYBiUZhRvOE4KTshP+9DI7OsRC5QwBQj/VxLJYnia9MGmihIDLfRhlpjBbbcR5rwpTej2KiCAWiI+1FFRww6288PwNTEIwNad5Teirpzzd1S5B+Er0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9Q3bmmX0Y0SVFXEdXQ5FOtVISY7aFrN9t8eFSxHDRI=;
 b=dm3korXgApYMnFAyoBqf7sLpqPBi/z/l4sueXFTY5ICr/k7gMmqYOw6mdESip6nilEWu9AU5DW9lynhCtagiga3cipa1jrtHlv7K8Q+oRoRVI8p5VVFysThmNJp2Tc+VXTvqCsKzpIvsPGK8CSH3DdpseT7OHYoepa8oYLUltkshFskDvXJ+ond0dcvkbL+yvD5ImxNvNH890FYS+BK1Gn+iiawlLk2zXvag+nk+OIMDaMfJCNZSNJJnQsMKwSNuVXOiPZLcmj/VhxDm1cxHhjjw6zVLR6DNM5AIACE6hVSg4gHdfP3H0a1TKAIpRQzSI+bki4Jv+99BZl5oGg1a8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9Q3bmmX0Y0SVFXEdXQ5FOtVISY7aFrN9t8eFSxHDRI=;
 b=A5H1PXRqucggfeeMUIIWa2EBqpt5ottyzXqpx/fmuHNJsETFv+/7QzJ0JwW0HRCR+1anAhj5hMpZwQsRZvJ03yVJPz5Jsc0QBn89zvBDk4Mm1XVwjplvbFTjqGVSuFOcqYvrOSQL2rVB90dt44exU/H5Y2eKms/zvqtiONFJmdM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BL3PR10MB6065.namprd10.prod.outlook.com (2603:10b6:208:3b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 16:06:37 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 16:06:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 07/13] mm: update secretmem to use VMA flags on mmap_prepare
Date: Thu, 22 Jan 2026 16:06:16 +0000
Message-ID: <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
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
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BL3PR10MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 402e74aa-75e0-4614-22ec-08de59d038bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?il09dWPZ0kOdYvNPbDMSul7uFf5aPhDGlq9wemAcC2FxYtUEQOEIIyTIhKSA?=
 =?us-ascii?Q?dIX125YoFCYpFX5qEIh1GykErQHqNFLftKFfx3bn80FWdDu3bMo+GoLU5x+7?=
 =?us-ascii?Q?RrxJlZl/Vx/MRmsAWIV+9oPyAq3uOqsWlC5UGvPvljTkSeDHhLwBItNLfp6v?=
 =?us-ascii?Q?cZRXFKoNj/zj5+uv7DMlC2YgHplsb37czlpWRqCX3R4apbQkH4WwC01sYlWt?=
 =?us-ascii?Q?HKg54oD1bDmJE/ZAYJns8szWSbzrJ5s6c6OqILJRATmKnpuVem+LalIu8Z4r?=
 =?us-ascii?Q?UY2DZpLiWkTFEVfoXrh9kO45xQRk72HMZGe1baWxkTcj88z6Bj7q3GqEodJU?=
 =?us-ascii?Q?Jg7b/UMCqtglbXk77/vkykV/Nyk5qgEehbwcaYg1cYJKnUNo6XMCxbqtojot?=
 =?us-ascii?Q?ko2kET93/9lhY4XHIDi2gNpSuszJGjsfQT756DUiA6IrB6gaSuVXHixyeIvZ?=
 =?us-ascii?Q?zKrd0ebsr6fbXrr9n/7cD5fUOeuABbz0+rt6tHV8A07MZpMx84anADByMhoo?=
 =?us-ascii?Q?OmZ+AMqQhL3o390pD2OoHajGac5i5fdFMPTGL44tp8ItI+6Y2o5tbuwq4a+g?=
 =?us-ascii?Q?oU+VI2YEBSRYD2PFXuL70YSmL5gja+Sd8TapYTt4der7nMPowY7tF1nD9maG?=
 =?us-ascii?Q?gxL5FV0mLaq4uiOT+JjwoWvy+AvL/CKb3/R78LUETscv62XFTR0Uyn8icJMS?=
 =?us-ascii?Q?DxKZammIndwn18Yo8T2r3jDlnvBhbXSFy0TiLxmm+uo3fOkkyBChUFVSHlEA?=
 =?us-ascii?Q?w/MqHxZG5HWA5huO+Ry5JSzkJROsAEXqoVfZl3Y9J6Zk1D1n87eFjOYX1y7p?=
 =?us-ascii?Q?K4etODX5+/GsVgbEFdLrFiWkGakCMfOnUcyaNW3YZOoLBKMbpAsq/aq3N0rS?=
 =?us-ascii?Q?XD8xs+FIgvKZ0iF8zmrZ3K3fj4ottBC+vH9fd5Y5hurtVnyYpfTXji5OMxE+?=
 =?us-ascii?Q?MHnPs/7ofnSoR1qrF7D2taEc4sbwLLJqXd9nyvf18trYymlPVF+G8TFVz0Jj?=
 =?us-ascii?Q?Naibm2Kxrccz1lL3CxPOsAOTwq7UbCDqo0ovY9Lf6S1hWT9DxV1vZLaHdw+B?=
 =?us-ascii?Q?dIOQ6fhqt2Bc0Iw1CkINfz/pyZp/2eOZTYYr86ACoQuOeDkWaI+F519yj+gW?=
 =?us-ascii?Q?8p5y3gF18ijVLOuXwMNdOHMvac2MzK+qMPPfDzNHidttflYpDYEgCmEo+/9p?=
 =?us-ascii?Q?oryqijed8+WE3IKzKt0Wts6+3Dq19X4Ctz0NGvvQJalH1LGxpIMUlSUZUDcy?=
 =?us-ascii?Q?0U7lW+M3UdFTHFnwGF/AtoDSTv4nc364rhRfWSqIpUhv5R7WkrVhKUz6xcsm?=
 =?us-ascii?Q?B45WmYjjucK2rcuy8QxSOujxfs5XAbet3PhIXB67PpGnbzTu0GBHYNEaqhg5?=
 =?us-ascii?Q?S/lqqCr6XlcLfb8j5B8rY7l1GQb3G7nKK/mQQmI8eKqHKpTmQGeinX9wX3Xa?=
 =?us-ascii?Q?qtt5RXDqOKbuiyktuj1MJ/4SO5WplXn9OfaNKvO0fObcbSt6TARiOy8SGIzG?=
 =?us-ascii?Q?UxV7jAdnosDbUwe8/ykQErA77/oGOCn15nqmRPGfwmp7SLd57N00kikUWEZy?=
 =?us-ascii?Q?+honiw15j9vyvnD7T60=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bj0VtQS2FlsCDRvhvrQw3Tytd55QE1TRlIcg0Qr3Jx8jZNs75qiEMAWg6NWR?=
 =?us-ascii?Q?zICnhV3pbL5envYvgcuXY2Fzg9NO5p0gZ841YN98XTcdqgVhbaJRVJln1D7O?=
 =?us-ascii?Q?uQI+VOgxcBQ/G5UVJEtGuEy/QefKtFPT8CBSOcuCxPIXruO5Mb7dQnFIQU06?=
 =?us-ascii?Q?PCMskpHMqD2gscScGtK5+zk9YKFir1upWbfFEGH1r2ySDiwyDWdsfGuS2BjG?=
 =?us-ascii?Q?mrXtYxTFPUROjzuqudLq04AYbSJ/Hm+MMhYMG44QAOhQjSozuTwxtrZLKDaq?=
 =?us-ascii?Q?u7RYpCClo1Crd8Brth86eam97kGCgmZ32+lJB68EFKvxAawEu2viMlGT/plm?=
 =?us-ascii?Q?Tk/R/o5i5c02j43UvZkFIurmepTVQt5oPeNji2RXWSj4DfCOFyVr3U0hO0qO?=
 =?us-ascii?Q?63zNRGPtoienX5DXKwoUtmeyPs+/KsUwWkuEFkgyzR5+wCsGb47b0ixkB6iL?=
 =?us-ascii?Q?TqVhQw13RLjssC44tzyKdp0WAmzN6rdtGzwU9GdctZL6mfXSWtel6bLJG/xZ?=
 =?us-ascii?Q?EdPhMSAfHosW2KZJ1S5P+3sjePrDdWRdNhGs+sbCU4RCJmX9fKAqnUMy4gp2?=
 =?us-ascii?Q?z0brNq4QLfBdloZq3rOUr4GBeSQSlANAv2AD3mY0yKc3lCFwDjHrYHwvR0TY?=
 =?us-ascii?Q?Mki3BSnSEFkUJkp5BgbE/TjCmEgtLgM7l0nc7grGkbaldQdx604cWknN2oHE?=
 =?us-ascii?Q?y0T0GVZk8M0dx5mE9v2xN029+jKs8Sh42BwfLjJ89j+8BMTpw2oXjFHBZyqV?=
 =?us-ascii?Q?ffcGYjF0K8YpocE3yQCyU/k9QMF5RmCcwMLaOEJNPSUOMLfG9NDeGtNb+BZw?=
 =?us-ascii?Q?+eB0ZM++aOZHl5zJDaVRe6FhmiS6680n7xqapF/fTSVVoE/q2HA1j2HcOHhF?=
 =?us-ascii?Q?Rk69rcO1KWbCNN6jgf4iz5Z9HMJfS8PIZbFvk0a4DxQ9PZ814d8LGht8j2Vn?=
 =?us-ascii?Q?VwMEllTYU1YPYNOMbn03PJrzO0hoHH441VULah+PVbAaNUW3PriUME/tkhIn?=
 =?us-ascii?Q?CZ5wjfOfHXW3YoSfzs+yIBd7SGkyUvpOVDE9kHSwrKdvOtye1IOSqpvesm13?=
 =?us-ascii?Q?HG40vZuXH0eiMjeHMIG9apNjixQBNOf2r7cYXZj/uworqR41jKVOANFa6Hnk?=
 =?us-ascii?Q?lVNZx60jICwNkV589NF2JVvnaBZhI7Z+b69qoKA7B/KDPOmos/bpGxurRrno?=
 =?us-ascii?Q?7/vNMaGEHRnGPlef6gLoG2LkRhX1Bd4vV1JaaX0i8I+0XIycJHiF38NeqaYU?=
 =?us-ascii?Q?ynvpuHej0QSMuLG/gdLOjXlYSvfxRWtNdR4pvf9BrA64kFtZejjJVatTZKou?=
 =?us-ascii?Q?UIRA+KDx9w1nNARFqUlmSm8TgFPiq3sgInfCpE8zDVNwHTscXDuDlqt82UFE?=
 =?us-ascii?Q?xeDibMXVfz4YoTyFbt8Wn4oKIzN2bd91PmL1Eut61dg2qIqrkdiJzmnRp6x/?=
 =?us-ascii?Q?x3zly5ldVo9H62ShMm2vsVRBUBNK+ioKasK21A6er0bqGLUoOa6/BJWt+Cy2?=
 =?us-ascii?Q?qHm+1Rdm2MuDyPHOVWafiOsuw0tyk3sTRN8yBDfYs6Qk2IP980tJiOlaRU87?=
 =?us-ascii?Q?7yZdCeOXy9R+drmlYL15u5ogbtUWqWhJxdVoMdiSOHPWpHuEDP2LeCnarfVr?=
 =?us-ascii?Q?g2qVw304zaxroU8bI2y6N5f1TRaC2OKphgs8/dCelb1GBRxs1MIg2a/rLHHG?=
 =?us-ascii?Q?mZaQxCTcPqHsDDxq0jTeZmc2Xrb1oVtqI5T2uNfUvefa4sr4YjXARDaQFYr7?=
 =?us-ascii?Q?rRmEW9g46RI1YSdBC7C0AREkfPBIk1c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OYAEXZbvfnV94wFJ3AkWaVeKxNlbI/Rf42q2KXMa5sBF79Xba/r+24uMKIhDnrq6FcODdJXVC+LDsqmEdh1LMI4jWa4v91Lk/qew4YSZN8blsbyrJ9WTIt7E30p71K0tMJApwQnmrPkKKX7U4j9osGcas4ajzQ9A9tjOVEnlb4V5l04TKedxyQNLrpbxht0ZlT8evSuns2NC0yct0h8P5kH4gU+cqZDPui7bgbqJAsaqgYLDKA1ek3Qz0oLq5bd3U6FB1eqUGvtWKmjdMQhCHFUD60mqkgjtWRlU2eCfGHM2ia4am/1ZUgQECMg3FVbbPqFPJblsTnIuTT1Z7MtYBk3vdY52xDklu1IMHtrmOQiv50B09vqMB+7Y3pP0YkAE6JuKbXmrOVtdF4GjAgzlBOd84+FLfNjE40HhczLog8eLeIa00ZPDuIW6ZAkA6jvTPyuvNpn15ee8HgDBTAZFxVfhaYnibP4ZI3KtAx3NzNhEjRTCF9wI8wanhqns+mg3lAufKTJrqJByC2YiFx6gWNpBFIw8+bXYUi8XRPu1to8Q87Gw5OZF97+XZ7n1myG4pvIJP5owYKzqJzmrZ8NGF5JrUsh3yykymXtnKD4YJ3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402e74aa-75e0-4614-22ec-08de59d038bf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:06:37.4935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IY4z2RkwG2ZC3PmjluqvXjrxapKIOFJ9MvqdrkcjIj97bs+j2gw//0cElne4i3Tg5FgQHbyP1aTzZVDMLFwGMTwV/QEmtTitcAc5oPd3QMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMyBTYWx0ZWRfX5ObAWnTEfjQf
 wmAAFtkWrKIyOn6jXI23rHSgUDIilA7Kwe/8aOqarYlDxvPrHoFzkUAEwEtp5GvRZgLecSZpTMY
 qWHmpWjm/icDmkVLUSGWNBW/X6XX5fRazW/VZWT/f9uBNI5xs6ce6C3baZfSQtBvngDHhMx7T24
 ZcC7rGND5ncmjY0cDjPA8uAfdujvp75xUPqLIzGSQWYFmnsUpYt7R9stZSeMig1kifQ8ktYbvoA
 8MxUsf5m96RCYsNa21p684cRh9deE2BSikiOwqjbowGkG4MThL+QxfTxqX+VNMmcdvPhx8coYId
 unEewiLAt5vx0f0KF8Aexaxv4oxK4BL0haNi9Sr0QuO+SIx2lV46ri6ECxKzURnDm7Tua2Q1tlE
 ZaQw1Roue6IWYhoUonSnV6G2QLme5AUDPfQqPBlNo43GlMUcXf6hODqY4WtLuDAkgkwN1wztK+Q
 dAo+f1Nzmxg/2wTmc2nojW6lC4fr+VEgqYwA5Kpk=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=69724b1c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=1EN7IFrRoGoyj_JuQOoA:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: ssBfsmTx-FyMiVG-bU9iAzXFexDYDL3Z
X-Proofpoint-GUID: ssBfsmTx-FyMiVG-bU9iAzXFexDYDL3Z
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[lorenzo.stoakes@oracle.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:jarkko@kernel.org,m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:bcrl@kvack.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@
 paragon-software.com,m:hubcap@omnibond.com,m:martin@omnibond.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:ziy@nvidia.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:jannh@google.com,m:pfalcato@suse.de,m:dhowells@redhat.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux-sgx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-aio@kvack.org,m:linux-erofs@lists.ozlabs.org,m:linux-e
 xt4@vger.kernel.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux.dev,m:devel@lists.orangefs.org,m:linux-xfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:jgg@nvidia.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2181-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,oracle.com:email,oracle.com:dkim,oracle.com:mid];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[93];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7E78E699C9
X-Rspamd-Action: no action

This patch updates secretmem to use the new vma_flags_t type which will
soon supersede vm_flags_t altogether.

In order to make this change we also have to update mlock_future_ok(), we
replace the vm_flags_t parameter with a simple boolean is_vma_locked one,
which also simplifies the invocation here.

This is laying the groundwork for eliminating the vm_flags_t in
vm_area_desc and more broadly throughout the kernel.

No functional changes intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h  | 2 +-
 mm/mmap.c      | 8 ++++----
 mm/mremap.c    | 2 +-
 mm/secretmem.c | 7 +++----
 mm/vma.c       | 2 +-
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ef71a1d9991f..d67e8bb75734 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1046,7 +1046,7 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, bool write, int *locked);
-bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
+bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
 		unsigned long bytes);
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 038ff5f09df0..354479c95896 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -225,12 +225,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
-			unsigned long bytes)
+bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
+		     unsigned long bytes)
 {
 	unsigned long locked_pages, limit_pages;
 
-	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
+	if (!is_vma_locked || capable(CAP_IPC_LOCK))
 		return true;
 
 	locked_pages = bytes >> PAGE_SHIFT;
@@ -416,7 +416,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		if (!can_do_mlock())
 			return -EPERM;
 
-	if (!mlock_future_ok(mm, vm_flags, len))
+	if (!mlock_future_ok(mm, vm_flags & VM_LOCKED, len))
 		return -EAGAIN;
 
 	if (file) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 8391ae17de64..2be876a70cc0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1740,7 +1740,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;
 
-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, vrm->delta))
 		return -EAGAIN;
 
 	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
diff --git a/mm/secretmem.c b/mm/secretmem.c
index edf111e0a1bb..11a779c812a7 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -122,13 +122,12 @@ static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
 	const unsigned long len = vma_desc_size(desc);
 
-	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if (!vma_desc_test_flags(desc, VMA_SHARED_BIT, VMA_MAYSHARE_BIT))
 		return -EINVAL;
 
-	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
+	vma_desc_set_flags(desc, VMA_LOCKED_BIT, VMA_DONTDUMP_BIT);
+	if (!mlock_future_ok(desc->mm, /*is_vma_locked=*/ true, len))
 		return -EAGAIN;
-
-	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
 	desc->vm_ops = &secretmem_vm_ops;
 
 	return 0;
diff --git a/mm/vma.c b/mm/vma.c
index f352d5c72212..39dcd9ddd4ba 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3053,7 +3053,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* mlock limit tests */
-	if (!mlock_future_ok(mm, vma->vm_flags, grow << PAGE_SHIFT))
+	if (!mlock_future_ok(mm, vma->vm_flags & VM_LOCKED, grow << PAGE_SHIFT))
 		return -ENOMEM;
 
 	/* Check to ensure the stack will not grow into a hugetlb-only region */
-- 
2.52.0


