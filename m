Return-Path: <linux-erofs+bounces-2366-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEfVEChfnGkUFQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2366-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 15:07:36 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57824177BEB
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Feb 2026 15:07:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKN385pC8z2yDk;
	Tue, 24 Feb 2026 01:07:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771855652;
	cv=pass; b=NpR4isNNo9mIIJBnE4C/9hWeWt+4RMuriUZJAzFyOIQB1yfI+mI3o3gRyT75EgFsyEmD6ASBBBu/8FnuSSS/gaErOpdJFhcDnSs/fN8Rnz/Xz/C21x4YMmFu9OJvOH3FVgV2DxYXzufDeDdGFCVi9Xup0AqsJZPV/lywJB71VweeMn8eMUYu8fuMMQErsQNK4dqa8eAKtOYWKMk+CHoRxVJuubn1lPHk3FfPtmUYJrRS5E3f3NZHbSbLyMNhsNG66oyZP4D+cvRWJgWSDuWNWx3GL15b709rwr/10ZOUYMGQugx2nZUXNOFObDOf7yhC+QtFGkVw/I5xJqvsIxNXiw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771855652; c=relaxed/relaxed;
	bh=2Y7OdAywcCZTamo8JbTLm03swxtZx0YY+69cEgHxznE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VUcxSeG/g1BLAkuXX0YcrJgbfRbqeLxeXr6ohK453+s3DSPdwKlcaE/w+0g3Bf/RLBduER6SZAmzybcx5xNwshlw+Iao0m/w6S9DePdIxmNx7zH6SUfAvtiNuJMJWJUvyzz8hJjjkRjwJIWUa3g468FcVyWMg73XgCkJ51lvXUnFTQG9pCyAo1y0jgXhKlPEeK0yKSIg1l+X6Nfa9FhLgR8BFGDyQ0QFrNxX5Sm0zGO8uczyGGQBQPJPs8TXjAOQLWKs4Vei6Elte8EYDEJkGU8DxNr/JwRHgOwVbGiUYsBSUF6u+IODSUfqzFxpK58yZZCGN1nITlr8fPCBkuz+2A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BBMEkQyr; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=christian.koenig@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BBMEkQyr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=christian.koenig@amd.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKN343lw6z2xN8
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 01:07:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtYH6bIW1eI9fIaLj2spl6rWMr47QbriTAJWwXuU0/cK40GI5U30i65krAiPK2mZuB6Ekz/deib03Nb1sFe0Rec8wK+SWGLZbJWvX3p42kkQSxfI6IkBKaLVhIpdmtrz+lp3DSW4TRhLQNWHy6bgU1m7O4uuV3bvu7tZGo8ZAVvCs9Y4MNjV71lxSi8mqOdD9Za61yeLGLc5Vq/coYFvkgoIoN2CxWm35ZauaedMlanbzge+YjeZbMXCcRAMwiQMc498r4/BeGaLqTkbfEBt8huezimYFcKHxr/WgwPyOpOTymVeJ3GWtlyxc/p9jcg7SxAorphALJMhOS1xaZFE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y7OdAywcCZTamo8JbTLm03swxtZx0YY+69cEgHxznE=;
 b=lq+B6DgHlzyYp5snk/QJt5KaEFO/NXNQzfaKRQGyoUW+ccD7RVcKhxQlCAXwtghkdiZlfY8kSxmFlE2wV1EGOXODM8lhWbgXRUrofl+o6WTDhHpdJ2ofbSZAQ1vkA7L/KkIJoZfhtktKY9o2VYEA8zqx0rc0mEOmXvFY9g2V/TcKGvRqA1TfkKmsEiUyn0a/q2vyXi2NLz6GA/oD0xm3qPfZZgH3cI/KP7WbzVmeGvTnMKBy+kGCG1oY56/pLUjSyb+VmRZNXa5+LVXzo/xXM7e9Yg5ykAQ3AmzJ6kmU6Ld8JG+y7ICwNH9p7DNxrdPPN6abof0qNrEU3mF3ApsCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y7OdAywcCZTamo8JbTLm03swxtZx0YY+69cEgHxznE=;
 b=BBMEkQyrNI9JSGoxD/bI+esfVOGnIOBUDpDAPKPEVdf8CZsbgSQe8PJwcnImc/9V9BNzdt9dj4R+8muJwLjfk8kIyTq2LiOivldIYqI6iRUlX3XvmLRK3xTTmD5J9qFhpmgcQOp7dZL4ynFYP0jbog/Mnp7xK1okHbauEp/I5fM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8071.namprd12.prod.outlook.com (2603:10b6:8:df::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 14:07:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 14:07:00 +0000
Message-ID: <cb8d6ee2-fd1d-436a-b934-aff87adf5dcb@amd.com>
Date: Mon, 23 Feb 2026 15:06:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Zero page->private when freeing pages
To: Christoph Hellwig <hch@infradead.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org,
 linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Eric Sandeen <sandeen@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>
References: <20260223032641.1859381-1-ziy@nvidia.com>
 <aZxaIEFZr2NvO2eQ@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aZxaIEFZr2NvO2eQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f83a17-4aba-4df4-9bd1-08de72e4d020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFdtcjlQWk1Odmd3d1BLWjlqeHlWelpKbkFaNm1EMTE4eldyaUYxcFpXWmJL?=
 =?utf-8?B?bWY4WnI4QjFUenhQMFpycjFmSGNSeEVvSjFpc3pZZE9tUGdqWFFNYkxncXZT?=
 =?utf-8?B?RjdCcGVTZTVzV1FhWWprelRQU21vNXZvbWF0OFA0Q3lVeGlmUTNDZFgyUXo4?=
 =?utf-8?B?amk0cGFlYXI0alBqQWNvTkNkZVFqMUw0cFh6Q0pZclJ5NUM0c3B3a1hKYVRp?=
 =?utf-8?B?c3JaV2RuWHVDSzlqUHd6WFUxS2xIcnpxd1VTODIrMWxuWkJtMFYrTEVGNyti?=
 =?utf-8?B?cmJsa0ltQjFwcW9iczF3LzVpTmlCbGlBT3ZHQ1ZVS09VTXRLZWtOM01XZnIx?=
 =?utf-8?B?U2x0ZCtSeGZYcHlkdlpseXBlalN0U1NqNEFUYVJuOHJWQ3ptcmFSOHpwalFh?=
 =?utf-8?B?MnBhc0llRDJCRW9qMGE1WXRVZUsxUWx4Y1NBMk9Ga1p2KzljeFM0VzdJKzNi?=
 =?utf-8?B?eUZ1bktETWpzYnZZYUJ0NDR1SStNbXRMcG93dWlTN1NsZGlHSk9vazJ5UEJ6?=
 =?utf-8?B?SlVIYUtmSjVhRzhmOUZ5UmFONGExaytWMjJidGcwTTY5MGExNE5YaUlCU3NU?=
 =?utf-8?B?R0dFdnpzeXN2SmNGRUd2NHZkVEI5N3ZlWVQxTmw0ZXdPWVFRbm52cmZ1QTRx?=
 =?utf-8?B?V0JNZ2crbzMzbmpUaWwxZkUvRHRSVGpKVVZ0TXlrVy9RUStTMEgrMVhEcFNF?=
 =?utf-8?B?WnFQeEExYW5oeTlvNkJpL2x1UzAvd1hCWTY3d2FlVjNXRDlMSkYzc2ErWnBZ?=
 =?utf-8?B?SDlaQm9WOUdVU1JwVjlUK0src3lUUzM0Y2UyRkZVa2RIdW5KbGJMUlQxOFh5?=
 =?utf-8?B?MmFVeWhxUGdSTWdLUUFya2ROWFRQcVR4RzVlYUxZWkMwQmlIOHROWkx3Z01m?=
 =?utf-8?B?ODk2bzdQYitLY1d6RzNXOUo0QnNCeUlLbXlzSWVSVHl6enVwamZQRVA0dUV2?=
 =?utf-8?B?NXV1bTYyTVBzMUM0R2JYQlVQTjdnajd6eko4VlFIcUlNM0Z1M28wMUp0QVZt?=
 =?utf-8?B?K1lvbWQ2ajk4UTFNVmRYWkZEN0I0Q0ltQXg2ak02U3p5UjZMSXhpUjhwT2hp?=
 =?utf-8?B?SEw1dWRxV1hOc3dLZml1Wi9TOEFCU1g2YWNtNTJNVG85ckkrZVVWMTI2LzFt?=
 =?utf-8?B?VFQrd2lReEhpaGZYTGl5ejZWUFVRaWdGbmE3M042aFBROHdmU2l5YzllaHo5?=
 =?utf-8?B?MEt2QUNzNG1kckp2OHV0dUFralRlL3p2N0FyakNoOHJQTDVvVnR3akdYNmR1?=
 =?utf-8?B?NmhlbWxYQ3Zxc3BCcnAwTndESTR5dVBwUTZxRXZPb3RkeDcwTklOME1LcDhP?=
 =?utf-8?B?YTFBemdacmpISzBJaTd6NUpsbCtZMnQxZkg1UGYxMisxRkdEeFlEV3NxbGl4?=
 =?utf-8?B?YXJwM2h1d1JvM01vdFhEaFR1dDBNUDFveTZxY1NEMTZZRFhPVWN4VmRJcDM3?=
 =?utf-8?B?N1dEWm91ZFhyMkROcjZHOWtHOG5VRExMQWt3SlhGbExScENlOTNnNGN5b09n?=
 =?utf-8?B?M2JNdnkxeUxEbXFrZmt1bW9CdmkzL0lMeTg2Tkx2ZFA5dk5XSDk5MnpOMjJo?=
 =?utf-8?B?aE1SbGZwTjFtY3lEaDhJTXhCSUM2MlNGS2trRDN2M1JWY3RVVlV3L29SQWRx?=
 =?utf-8?B?TVptbXFVSkJxaFNhVUxpNDZLTlUzY2taOGVZbkZseXpJWVJzV0x0VW82c0JF?=
 =?utf-8?B?UkttOHFjMmJObWpBbFNKS2ZONE1ZdzA5S1B3VTN2eGNVQms3NGFHVnBMeGpl?=
 =?utf-8?B?Zmd2b1pyclB0UnBXTTExK1huQklBellBNTlKdE5CU2F6OEJwcy9jUXRvQ25j?=
 =?utf-8?B?TU1rdGw0Wk1XeUxLU2Nlc1RHbEYzY25RY0cwR1RpSjcyNEl1UDlhNTNuSVh6?=
 =?utf-8?B?S0ZMMFE2N0ZkKzNjYlpaWjZ3azQ0R3MwQkNyaG1ud0YreVg4UzAzdWZkb0sw?=
 =?utf-8?B?WEVNOThjYzEwUWRGVUl2MmJjL2kwQ2ZaOUtBZEorNFNpb25MZWRObUUrSVZL?=
 =?utf-8?B?SW82QmpWVVhOUmRjckd5T1EwSDRCWG1BOW1BeDRuMGRwaTdUQW1RVzFJazdW?=
 =?utf-8?B?Qm9DQlpvN3pRd1g1dkZjY0RYZFlNVmswcEpXWUUzdTk3ZGJyOVhSQkRTYkpo?=
 =?utf-8?Q?p0u8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE5CclBhSWlFWTZjeFAyQXlWei8zVm9kTHpRZnpXbHJOdWl1Um9ISUJwdjlF?=
 =?utf-8?B?dlVrQTFNdk52bU1oQTQyNks3MTBleW1pRGRWcy84empXeDk2bzRQVGU4WWln?=
 =?utf-8?B?a3pVQWo3SHp6bkx4Mnh2eG9DSUZQNmRub3Jad1pIYWJhWlcwT1dYc2xzcHFR?=
 =?utf-8?B?NkFnSngzTzNWR1o4N09BRitRclZyLzJHWDJsaElnWlYxYzdlaVE5ZW0wUnVM?=
 =?utf-8?B?TnBVNDJsb01pQU54NnA4aWlEREpIaHB3Wm9Ha2VKVDJ2dEJLQk1EM0RlVmkv?=
 =?utf-8?B?ZzN6ZzUzV3NPS1pOdlErM0w0K3VoYkFqY0VSdUxENXhveTRlTGZWNy9uMkFG?=
 =?utf-8?B?SC9tcnRrUzJCcklrR0VjeDc0QnJ4Yjc3ay9SMDJDMFZBZmlPSzhlQ1NhdCsy?=
 =?utf-8?B?L081Z3ZDZElocURsbjg2WjdoNmxWejlybWcxcGhxMDFkaXZqd2tWd1JsWnVI?=
 =?utf-8?B?T1RwVWJxZlZYNUp4UXNmQkRVcEVRTllPYWtSU05idHAwUkl6SzFGRGxnelYx?=
 =?utf-8?B?d1EyNzk0NHBSaTJWYlJ5VUJZN3Bpcm5xaG5SQ2NVaHZEUmJQOTVBUzVrRUwy?=
 =?utf-8?B?V3ZIZ2w2bUxUZnorOFFWQU00QjdHV0ZwRGtBV081Q1hWdEhWVHRmMmRaTFlp?=
 =?utf-8?B?SjBGcjRxMGE4TW5rcWo1cklmUG1XWVpWWko1MVUvZDNDaXdYZ3lZVXRDNC9W?=
 =?utf-8?B?RWJvdUxuM3lzOSs5NWI0OUpycDJtWjBUalFLclZ5THRBQm1YOTlFV3ZlRWJl?=
 =?utf-8?B?ckE2cWdEWmhEd202WGtCUFNnMWhrNUwzd3YrZm9zTVpCZml5dXgxOHRJbEtw?=
 =?utf-8?B?SVF1NDdydkptS1RIbG9MUU1mL3BaNHorVDI5NDVKRnI4S01Qb1lBUUZJVUFN?=
 =?utf-8?B?MURzQ0ZkSHBpUW5zRldZbmhNRStUekVHTVdxU1RjM0FqbzlCVkhpM3ZnMHBS?=
 =?utf-8?B?c045VGVEdk41cmVDeEMrWHpCMmYwV3BYTHdseFAwN3U5cnI1WEVqMC9zdERP?=
 =?utf-8?B?c3ZoTys4TnJ1Z0pqZmd4RCsrU1FaU2ltYUtQM3F2ZGJoSWt6cnA2cDU3bXRO?=
 =?utf-8?B?MFNpYW05SWFyM2FYb1FYeXpnenRsanYvRkVINllpNWFQc3lBWi83TFJ3SVRS?=
 =?utf-8?B?dElJS1FsTlVWRVpvdnF1LyswUVIrdTkwc0xCeUM3UUYxVENwUndNV1RFMnRk?=
 =?utf-8?B?anFPQTIxNXdTcy9xY1dnOFdpSGRQbTR6NXl0blhSZkFFQ1hsVGJja1VFQkk0?=
 =?utf-8?B?bVg1K1BLbTR0eFU3WFBGSWNxRXNMT2h2VHkwMVdpczlsRXRmSmUweHRFTjY5?=
 =?utf-8?B?VmdNK1kvVXhWZnBkRXc1R3lUVlg2STRSdWo3YW1qcXZwZUZSTFNST2lFTkhU?=
 =?utf-8?B?M2U5eWx1OXFPTWxDR3M3aC9XSzJ0MHRvb1hDbU96SEJmRENMakRUVGw2YmJm?=
 =?utf-8?B?cWRkRTY2R2FDRUVCMDZ4ejROVWdGTWszeStHak45c0NJMldOTFA1SHUwcDZp?=
 =?utf-8?B?aWRYRnI4NDRROEpIWlc1cXlwcDdXRVgvWUlwNjdpeDgrZElGSUZYZHBsNnRx?=
 =?utf-8?B?WlpETVVmeURFa1p5VTBqL2YvSnJFNGxwYlhabDlVZG5ySnhMUmdqVlRHSi9h?=
 =?utf-8?B?Ty92NnlIVk02VTBxTlR2dWJVUUF1OHVqcDNrUlBFYlJOOHl6WmJIdUthczAz?=
 =?utf-8?B?RWVjK2FjNC9qbU5kajNVa2p4bzdkNzkzSm56TzV5NVpQTG02SEtWN1hGM0pq?=
 =?utf-8?B?TGd2RW1PTnhyYXloYU00bzUzL2x1dU9EekdGUW9ESjhFeEZpdHNzTFRhdlF6?=
 =?utf-8?B?RitCdGUyMi9KTE5nQmpqODByMW0yVk9FQmdBMFdKZ3BtN3dPNVA4cml4dVVS?=
 =?utf-8?B?VkVQUEVpcmU4VlBkSXFzV2VldWhOUm5kYktqM1VjbUZaWFNyblpVODJEc2lU?=
 =?utf-8?B?RmdqVk5xUjBYMXJQTm8yU2FGTHYzWWRMZzRTYStyc3QzUmlkeFNlTlZqcjRP?=
 =?utf-8?B?cE8xazlmM0VTRThSMUdoTWl0NzBHV1hjenFyNWJqR3E0VGViQTFEVDN4MWJx?=
 =?utf-8?B?SHlQc3JsNGZib1R5MHFrUWZRRURHV3pxZVBqTHhWbGt6N1ZEUk5MWFlUOUZB?=
 =?utf-8?B?UFZ4dnp2Mm1yOGxSRnpGazZwZnpSNjFaOUNlTnRPRjcrc2x5QWVhMnVqKzFL?=
 =?utf-8?B?aXlQL1Q5b1NTYUhSUHhTb0xua3duK1NseUFzNmxhNkV6cWtKZTFrUW9lODFB?=
 =?utf-8?B?L2lTRCtPdE1ybGN4K0RKRG1VaWtDa0U2WTg5WmswYVByREdxaUNFVEVXRDAx?=
 =?utf-8?Q?gXSsj02wfp5XlnYe8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f83a17-4aba-4df4-9bd1-08de72e4d020
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:07:00.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXCpHyxCbivXXQtH5b7IK4mVPCGYrMQx2k3yIwvIsWt88XHoOeA5kWo4K5d+Mp8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8071
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2366-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:ziy@nvidia.com,m:linux-mm@kvack.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:linux-erofs@lists.ozlabs.org,m:linux-block@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:baolin.wang@linux.alibaba.com,m:Liam.Howlett@oracle.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:kernelxing@tencent.com,m:katrinzhou@tencent.com,m:mhiramat@kernel.org,m:vbabka@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:harry.yoo@oracle.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:axboe@kernel.dk,m:brauner@kernel.org,m:kprateek.nayak@amd.com,m:dave@stgolabs.net,m:sandeen@redhat.
 com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:cmllamas@google.com,m:aliceryhl@google.com,m:dlemoal@kernel.org,m:johannes.thumshirn@wdc.com,m:dennis@kernel.org,m:tj@kernel.org,m:xiang@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org,oracle.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,google.com,suse.com,cmpxchg.org,tencent.com,gentwo.org,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,kernel.dk,stgolabs.net,linuxfoundation.org,android.com,wdc.com,huawei.com,vivo.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 57824177BEB
X-Rspamd-Action: no action

On 2/23/26 14:46, Christoph Hellwig wrote:
> On Sun, Feb 22, 2026 at 10:26:30PM -0500, Zi Yan wrote:
>> Hi all,
>>
>> Based on a recent discussion with David Hildenbrand on page->private
>> is not zero when a page is freed[1], this patchset is trying to fix all
>> users do not zero ->private when freeing a page and add checks to make
>> sure all freed pages have ->private set to zero. For compound pages,
>> both head page and tail pages need to have ->private set to zero.
> 
> Requiring the user to clear a field before freeing is just a way to
> awkward interface.  Don't do that.

Completely agree. This is just asking for trouble.

The cache line(s) backing this struct page are most likely accessed anyway on free/alloc. So I don't see much extra overhead.

Regards,
Christian.


