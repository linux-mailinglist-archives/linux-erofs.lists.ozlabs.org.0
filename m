Return-Path: <linux-erofs+bounces-2103-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DXlNX2yb2nHMAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2103-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 17:51:09 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE5F47F8A
	for <lists+linux-erofs@lfdr.de>; Tue, 20 Jan 2026 17:51:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwYHZ278Yz2xS2;
	Wed, 21 Jan 2026 03:51:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.165.32 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768927866;
	cv=pass; b=SxX9ybsWJHeEoBoxnHbvfGP3xbNzOvB1eJly3WgeTerpnDeeUmdLPlAn8gYhVl7lLHGVHMD825K0E6VYftB5NnlIpDYAy6D5cani3TIGvoxOUqrx4A2kji2w33fG2JXa6cMvQZHQq6TLZhV2Vp/SokNE80Ny2U+55JdkC/PzVGPHQhp3DVC1YPrs+zCGICnMCfgoq18TTwSp6Elsv1YRL0dLlSaE6O2FcxiewunGKuGrDukjDUrULk/nqXCg+dvADAgL/qxz4bxB33JYHcLFRJjcvEDCN2QlfwEeCv7H2SBKveOF20voL23m3PUQdXPoiQ4Bk1pyJCIddJy6RTTeWg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768927866; c=relaxed/relaxed;
	bh=dWPsAKWWNqF0UmUQSyaKlT6iCFPV5OdFrD+24wSbB3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPxg291W4DitgPNpB6BNSzwuP+SLxTorhXIrJQEnzc1KbMxVzNoK6CWRuav2zaldW+/eEu5OWnbSh1NfgXIBmBYnhr4jKwqtiD0ZRYCJRNW7uk9RUn6NswFiqusEU/XikCZXLfTSNdQeJLFsUlWWc1X9Zb+8+ZvCDJF3bFbmQKIRNau4m9ezO3TXqoECeNNHYH3Pqm/33nWgksDnAJNZ3OYvsqUD+4biqK01J/t7mpq8DOpTEm2AepwDTjCrJqUWWMOueSW5kNlGYZUQSG94XWy5c+iChMaRturlWaWkpRQQXoxz2bUG///FMtkXjw5TnU4wDcLCmCMdWJJi3VqO1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=NLUjnCFg; dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=iOdZUzSO; dkim-atps=neutral; spf=pass (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com; receiver=lists.ozlabs.org) smtp.mailfrom=oracle.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=NLUjnCFg;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=iOdZUzSO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=lorenzo.stoakes@oracle.com; receiver=lists.ozlabs.org)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwYHY4DxSz2x9M
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 03:51:05 +1100 (AEDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7upR43028845;
	Tue, 20 Jan 2026 16:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dWPsAKWWNqF0UmUQSy
	aKlT6iCFPV5OdFrD+24wSbB3I=; b=NLUjnCFgoTwIfDqxD70C87YCtG+DWTDTM/
	b4W2ZN8MJG1gorLu0lhpC6bL91gtFJozJutmVmtAylgWn9HTG7GY9WZ2SWq/ZE26
	cYCzYQln5Jy9NQ9/p6CenVU0IHGOMBYKneKVD1UrxtkeenCE2+BXr4xGrtGdKl3/
	MfOU8JRSk6gYEEu/+FLcigIbZTZviNBLwD4qGZ5aKAlDw6o6erP7lwJVVRkRlk7K
	yYtU9QvRaS4QvNS7usIygElYrWh8CYYZ4f3ylGdpS+MrtJZ4WcUFJcVM0ptnVNYc
	iXyzdPJwQ9O1UswbIejjIdtaEBGvRsCEuwJZRYJsEb1DB7VpqEeQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10vv06c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 16:50:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60KGjHSP039561;
	Tue, 20 Jan 2026 16:50:30 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v9wmym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 16:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GynYXTq7dohvWOlkGi0giYjTrXgBFgb5ekj9O8NqUSaQWeWEXMqHcqs5IigycXSK0oJDhQUygHQBlKrnFg6BmUckNAyqS9Bx5puyLtK0NNr0t193EF88qoQ2Q1KngQihEKgeh3RRbomArFB8VLG+njfsovaS4Czs0t/vyfCrNccLubejkHgbYaKloG1RgespLE05LaIGwE/NQPOJLS4QfTyWhT7J47Db+tA64UAPsvEaIpbJOAAII/POwf+hS5zrEB1LfiPr7uBYDBWPNgcGgREFPE41xdqWsTzCUayA2Os3fFAig8ixCobVB85ZtcvjNiWgdXmVdehLKZz5nAgmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWPsAKWWNqF0UmUQSyaKlT6iCFPV5OdFrD+24wSbB3I=;
 b=oXO7W3tYZFN+w1F9b6Fl97lI3FkaLV4XqErxl8+GF9Kj7AfscXHyBYc6TAKVbovoNfmMM5fSEpAWQTPdfQV1g4JxgfOezO3gmPPNESIaHOJ0nv6lVFX9d+x2bb1Cx4RgseSW6KbSXWg0p8Hm0Hy4bYQLyMam6hKuR5o/++hGOFDks9nJY2b1jfkMZ7n/2jl09VU8p9gn4pqgwz9aFRdRvxthMAAOzieAkMUTTb04a/vf6VsphZF0XVwkPQFeG9VS9P4JLn2FBOcRrJXD6OByJvpbL2vPPYZaNN1+qBiDdoBArxkzR6wHkGZb/7acpjhyr5QKNr6H/OfH2v3Wh8UQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWPsAKWWNqF0UmUQSyaKlT6iCFPV5OdFrD+24wSbB3I=;
 b=iOdZUzSOWVmzAG1YxnAxdqTDbNDhj6cZ+v3/u6O/pnpHdo0vO3Hbjwd2svLReGabJ9tt7y8x4PcgfxHMZu8GQnVIkKOcnCTmpc3hpmzH/6ICnpEub5vsb0oH8IcAVZjmbRLtYqf6/T4wIHGnyMYa7GLzQ9tU+vJe8DF1ZZZRUw8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 16:50:18 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 16:50:18 +0000
Date: Tue, 20 Jan 2026 16:50:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        "David Hildenbrand (Red Hat)" <david@kernel.org>,
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
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
        devel@lists.orangefs.org, linux-xfs@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND 09/12] mm: make vm_area_desc utilise vma_flags_t
 only
Message-ID: <7ac64213-26f9-470c-bf6a-abd1c0f6c83d@lucifer.local>
References: <cover.1768857200.git.lorenzo.stoakes@oracle.com>
 <baac396f309264c6b3ff30465dba0fbd63f8479c.1768857200.git.lorenzo.stoakes@oracle.com>
 <20260119231403.GS1134360@nvidia.com>
 <36abc616-471b-4c7b-82f5-db87f324d708@lucifer.local>
 <20260120133619.GZ1134360@nvidia.com>
 <488a0fd8-5d64-4907-873b-60cefee96979@lucifer.local>
 <1617ac60-6261-483d-aeb5-13aba5f477af@app.fastmail.com>
 <44461883-a75c-466b-a278-97c4ab46b461@lucifer.local>
 <9ff58468-a72d-4984-95f4-d0a60554705d@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff58468-a72d-4984-95f4-d0a60554705d@app.fastmail.com>
X-ClientProxiedBy: LO6P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::7) To BL4PR10MB8229.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 599f77b5-bc63-4e25-b92c-08de5843fe65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0JgHC2OyT45OYyD+FXSSGS7riDFC4SWESYimzU8AxBki3MAtKO6/DM/rjc/?=
 =?us-ascii?Q?00bdEhr3vFO0dWj9HgB+4GnK5DB0mkgerJnnxO8W1CVZpUBjhRJn++Zlbyhu?=
 =?us-ascii?Q?YMd5MvEXmOeGfaDnbhB1YLFBECsXrkrMFImh3/zS+xqs1yC4jj1ysVZhe9bs?=
 =?us-ascii?Q?UerQBPnF4lfhjJ3QgaQY9A+sRYbHjlrI5qEBQWDjSw93bWWvn3krWZIr5FNA?=
 =?us-ascii?Q?MUEudHw4ZAIZwU+Cjq+YU6kRfVZUCh4Ir1vrtjWjPgoHF+mD3QPilZ/2Vhhd?=
 =?us-ascii?Q?Vvh/AmbF0nU2ikUX8g1KLuj9yloSkFiVvMh00E0VCzAzM//H/Vgp8ODE0dkf?=
 =?us-ascii?Q?v788oSmL7aSv+oRbmAtI5MUfrkw/xWYnQdWyctvPnFTiky9Y2WEfuKCqqe7z?=
 =?us-ascii?Q?TLswWkV8VwnvtvmR8YBbwRA2C31k/DFCkUJ1vL2y3daJ0ZWsEqFg/7/2B5Nk?=
 =?us-ascii?Q?A2iYi7cVLW1eOxoTO48y/YkGI+xjTnR9dzmuiZMqd8PW5N4N2WF6HZvyyp8A?=
 =?us-ascii?Q?de9Rj3Ov/EAl/B43SftpqMA/aifccxFl3TAPaM9CJj1/eLOOdAOAn6LmXP9U?=
 =?us-ascii?Q?Ms2avF35pTKiZNJbEC2SEI4iu9hTgvNLMX0fIIGbKP0tYMAgdBNdFGHdF5pj?=
 =?us-ascii?Q?FV1oGVZE5YYs8NWJcrTZ9S53dNegwLMXIgEgkDwmr2GPrT+1gO0f024JrlhN?=
 =?us-ascii?Q?viqJfc2DztDSnpnFpc4M5xyrLzkSNzW2qcbjGjNgi9VDAyHu9gqnI44XxsYt?=
 =?us-ascii?Q?7ucsWdO8n0IBw4Xebj0hp1yEvi10MuFxvv/JZqdrtj234+XsT2VbqSnlOVpH?=
 =?us-ascii?Q?u3IyWIW++mwzi2kyyblRMK/Eov75uzYzD7l4Pttgh6psKAqhwcZADLVtG75N?=
 =?us-ascii?Q?8mW/KXwfh2D7d/6AY4t5qwqjiKuTQDoB3wjhjZG58+UkTUuEJrNEcJWG3o0J?=
 =?us-ascii?Q?WLKgfQ1/lh5wA4lIdmI2iQAuCUhMJO5xTjV2RWeWxG14cORDLLS521W4U5p5?=
 =?us-ascii?Q?AcoWGQyQ8Hf7sdQDwgn+WCLO7g67kTIECjvjSU1KS10V+uvW6hEFImhZ+NqE?=
 =?us-ascii?Q?7gHANNxgoZ1Vx5eyBVt9hcnyruHfejlaIBiBntd3yxXueHbPiTLV8Nq0WH3N?=
 =?us-ascii?Q?76NAa+i0SFBszYwT8eAgqZ0LszVlVpabLiWIyQARq6Q2evWN4E6qZS4C71je?=
 =?us-ascii?Q?U/nLKXvjXFSHyUuJbcYG2MlmDapiz6UaZcXG+2uVnQZf4sNAYJc0WLv/dos1?=
 =?us-ascii?Q?U618To41Zgxz8Q30GwikRyO74h5ryLgBNcHlIEqnVOeb1EZz7NShjJwb4Apa?=
 =?us-ascii?Q?YpCHowRlqwGuSrNU6YM8y6v6PojxnJqiiEppFeLIYYfkDfm9Z1CuhaS1g/zW?=
 =?us-ascii?Q?kWRA4a3CzV3HWUKX7AcoFgmSqK+9y66G9i9INAdtJQ6LrVjPqBT+ax+pdx0d?=
 =?us-ascii?Q?zC+gV2UpbzsPJLoRNieL5OQIp75GfMLT//N9CyJpHtKcD0c0MK7yxJBKsp23?=
 =?us-ascii?Q?yGAGQwe32xMxMcCA9/SByp/BgKCW8CSmQ8J6ILk4L/4f18+8240T9nAJIzuC?=
 =?us-ascii?Q?QhNaL8W0AGV1PrLhMjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZrXPCfaeXhU5byniXN+09zmc/WT9fhj+QwXCuyIcVZLxveS8e5j6PXAddEYE?=
 =?us-ascii?Q?QKW0PsZUTqLG9goUjphAdY/tBaMVIX+wJ9J0kzRnMCoOXSe4X7yFZ3Dj52sm?=
 =?us-ascii?Q?QhEcQlI8ohgw2x7YOzHzRk9btjYcOcyuibOAMYRL9QXjQrX/fETXwocFgQne?=
 =?us-ascii?Q?Gyji80AzaBrSiAD2VqZmywtobV2Q+BrXWHGj1f+Y7/mq0JjPuxWYnQaU9Wg8?=
 =?us-ascii?Q?PpOnxQk1TA2H1VJCmLtePriTb5GBuOPPmJRYP1CHur4nZgdRQCc7mKGF2qoG?=
 =?us-ascii?Q?bss/EPNjyKFx2SB/tjKbrebsmIOn/PZoU6JwzbJS5FjUwOyN2btEfXXZ/+7t?=
 =?us-ascii?Q?GFdwEEE+/jYwkthGjIoXIIViyljDpdv9Ko1dvxkYp+ljcm+ydxjdq3ZO+GVk?=
 =?us-ascii?Q?ZzSiF4jWt8yuqZIfSP8AgLqawd4ovTrV+yYuDmVI0Ee9VMob9ZpYZgIPLXXo?=
 =?us-ascii?Q?kikfd+bWM1uUKgfkwgqDv72a6lNqlvtlPykRhjulcealkKil0pf4rmeY8QE6?=
 =?us-ascii?Q?Ey42anuVHKQvQqOuDV4z8jfT1vHL9857Aehtxui3Ks4qQTQ+aU30fJ7hNGu3?=
 =?us-ascii?Q?4y4U5o1vyXHUidpw+Ha0/8N6VmINbZRG/AnCFIaQQFq5XikH3rP24s3r/+/1?=
 =?us-ascii?Q?wNxFHh+zsRdB1LPv1qIpXJbcZksQ2VYyspYKSUkKy7gXSNjajRJ44BHZVmYN?=
 =?us-ascii?Q?2N2FOqHBd8zr7vibbIbFo88TZHffVrNBBeOTvGBo8VjVJRjuKcXeJYArMOWf?=
 =?us-ascii?Q?oEjWajJcrqJajHRXiIv3tTvqBAuyiBcdYdC5Vbk8WkgtjWtge2y7k/tANk4I?=
 =?us-ascii?Q?H5BURgP5VX8J6a3HXQyRTNb8fDyvKFzpk9Aa1zpI97fKEl7cLa8jGLsIFd/x?=
 =?us-ascii?Q?aCS+Ib+HVYaiSOWOx361fxVHC4ORl8FvJ5VORSarvmLRc8WMD5R7EOO2/+kX?=
 =?us-ascii?Q?Qx83mA/dWlfAyYoT+eCGzW6Gf/FLWSus2W+nDJ0rm6u/Gom8NxOlQUZoCvYq?=
 =?us-ascii?Q?RljKOVii75+cNzV3um12baRBngDGM4gVopmDqmXbucwwR/55PG5uWvP8cnnS?=
 =?us-ascii?Q?cTKFEp+uNUlzTD1iUoVQ4fd4NPc9n9aNy7HD4QtkELUyj+R0IHHBOModUlHy?=
 =?us-ascii?Q?pexU4pWAX83os6+817wS7M2ocx7GvicbfCUXkZiL7WJefWmtTVmObrkLkWne?=
 =?us-ascii?Q?9fZXVZ6hmol14NhXcCMGtrmCbQ80AKzwjLJ8ZcM6SgLxj5mHCYm+WOgfBP09?=
 =?us-ascii?Q?ep7JMipcba7evk/tvoAzdu+mUUrzdoKa2OOMvLsAQCQuboOCSwahYPDzyDEy?=
 =?us-ascii?Q?vUmh4IeYY5/YOP8Wje2xCM8dTRXRTFQnMiLjXgzI7N7UkEPUFuEUL5iGxg6F?=
 =?us-ascii?Q?4byEvQ+ovJMG8Io0ni0lDQ1Ize7Pul+f3GAw3MsNwrOz6CBb9K59Mle1kmNJ?=
 =?us-ascii?Q?XBbFY+m7iw3lEy8Q1yEJbP9Zo01eplm5DEFc18Nk8szxNXj7vuHU6g3Wv7gT?=
 =?us-ascii?Q?4/728QHf/0H/KVuk033L+eJv181BUbyU5xRuc+eZbdXUET9mjSy5wzmWU6aH?=
 =?us-ascii?Q?nVQ210owjoHQK1v2RSUk+DW2rBikp2ho/oXXRJxYa54zpjQ8Er9JoMwFyhQ8?=
 =?us-ascii?Q?1+xnJpP3dSpkLngPQFjlMfifxfhMo7wMcwcBGmwlf9zyIEU/VOgXT658ny3z?=
 =?us-ascii?Q?l8TiW9/v6Friz3nOtSZn4JTSc3fFWmffxbB54OPUU7kDYv5rApMorvprOGyk?=
 =?us-ascii?Q?Q2S7fFaPjmgUYlOvigYgUwMHMTCwL4U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	chOOwHhUu4AZbdz9DlMTarn+aXBnCVKBIfhLiyV7Aeyurn9PM5C9ibp44xavTtaa9GQlV5C7Gr+mq93vPYOqt2q6K8T2wDbjUr4QAdLCLQt1cMWfZ2MOvXpmypKV5j6+Jb7NnQ+1aY/FjcX7bjCApeDwHQP4yWMcFW7TYNk7GGlaeMNzLg2Tk6E7j2t2PLpIZGcxO2xqeNZrNw3ZzhB/cDQPfPRK7lOuS4YRgFPVwm3w1UxJGsQKcXpI+EaPcN6+VjyCZ9AqFmS8NhCBs79QrTewgTsA8Eg0hufpHPOPfKfa4liwJ4s56spnwS0/+Uc7mVr/qnEYQADUV9H4VBprmH7Rz6oglHBjwh5RrKxB0n4pin0v8CFkZwshfEx0VHcHT0ONk047ncRNceEFPMXVEmANrL9NxfsJLkiFv3KINJegtvN3H3YV96clcl2pEV+MiAXjI1T9HUU6oB1tE3JoZ+pq2IYm+pxxzJSUBI5T/1sG9MN/e9n/fPxjDESzK6Jjl+83VVnBob6M0IwHWOcEloXUbmxcEpeay3XCvykW3qAeTpHfoddvJDo3eYC/wyvfpiQmPvKl/6qWVk3LFpvg46fiyslJ/xK+P5tHHeYHvL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599f77b5-bc63-4e25-b92c-08de5843fe65
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:50:18.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKFdNKqerOo0hwzGfEp3cX2jdHVPncpMAMD73eY5egQFeCSy6L0sktwc8juQat5YONUKj41onxqITId2tNXTICM/hX/i3D3aQpbgiiBsHMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200140
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=696fb256 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=90Ukn_98quSV7Lvi1P0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: VYQO6K5M5jh5JHmBNwhXW7mvnKN5BzTC
X-Proofpoint-ORIG-GUID: VYQO6K5M5jh5JHmBNwhXW7mvnKN5BzTC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDE0MCBTYWx0ZWRfX74WuK404jhOp
 gd2cOrrAocNqLKIWCimOzcFCkoyn6sA97wP43VtIZ9D3nmtgdD8GdT0b3kacqF/rh9sKaAvgtFx
 0bba/vbsi7pp/JTOlrb0hbNnvjjLjSj7MVM5QknuKl+JSeO096lzhOmnlc+/vmsnLFZdEWWfZNa
 oYgb59SBQFKZFoIKjIUq6SNeVP0WvTl6ch6GakemgsF9THqtl5NWA0hlPeh4HgNDhZA6WZNhfsq
 9en/Jf+ptQ7w2RHAKeD+Qt7+UIaCgsyeZb8pnzFEHMYcxFHEcDasPknVw8G6V0Y67M0TFk+Wh0D
 X0xO/A3Oo8WAtCfzjNn/JnFszI6pi+VfDaj18DdXotSqCnmFQ/vm0uOcZU3A+XgLjIMfSbBB6F+
 ksA8kvM2ORZ0pgvW4787jGDTdLML3gZ+aOr8a+mpYRApz67uYr3wboPg700wXfQd6yBZ1t2yojZ
 Vr833GWhxDH6AsDJRJA==
X-Spam-Status: No, score=-0.9 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@arndb.de,m:jgg@nvidia.com,m:akpm@linux-foundation.org,m:jarkko@kernel.org,m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:bcrl@kvack.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:alm
 az.alexandrovich@paragon-software.com,m:hubcap@omnibond.com,m:martin@omnibond.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:ziy@nvidia.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:jannh@google.com,m:pfalcato@suse.de,m:dhowells@redhat.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux-sgx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-aio@kvack.org,m:linux-erofs@lists.ozl
 abs.org,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux.dev,m:devel@lists.orangefs.org,m:linux-xfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2103-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lorenzo.stoakes@oracle.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCPT_COUNT_GT_50(0.00)[93];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DEE5F47F8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:44:29PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 20, 2026, at 17:22, Lorenzo Stoakes wrote:
> > On Tue, Jan 20, 2026 at 05:00:28PM +0100, Arnd Bergmann wrote:
> >> On Tue, Jan 20, 2026, at 16:10, Lorenzo Stoakes wrote:
> >> >
> >> > It strikes me that the key optimisation here is the inlining, now if the issue
> >> > is that ye olde compiler might choose not to inline very small functions (seems
> >> > unlikely) we could always throw in an __always_inline?
> >>
> >> I can think of three specific things going wrong with structures passed
> >> by value:
> >
> > I mean now you seem to be talking about it _in general_ which, _in theory_,
> > kills the whole concept of bitmap VMA flags _altogether_ really, or at
> > least any workable version of them.
>
> No, what I'm saying is "understand what the pitfalls are", not
> "don't do it". I think that is what Jason was also getting at.
>
>      Arnd

Ack sure and your input is appreciated :) It's important to kick the tyres
and be aware of possible issues.

Actually I think now I understand where Jason's coming from - the by-value
cases will be const value for the most part - which should make life MUCH
easier for the compiler and avoid a lot of the issues you raised.

So _hopefully_ we're mitigated. Again as I said, in cases where we might
not be, I will take action to figure out workarounds.

I'm excited by the proposed approach in general (+ again thanks to Jason to
opening my eyes to the possibility in the first place), so perhaps a
_little_ defensive, as it allows for a like-for-like replacement generally
which should HUGELY speed up + simplify the transition :)

Cheers, Lorenzo

