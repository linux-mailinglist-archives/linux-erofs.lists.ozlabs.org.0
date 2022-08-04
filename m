Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E8589E71
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Aug 2022 17:14:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LzC224Mk6z30Bm
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Aug 2022 01:14:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1659626074;
	bh=/Fu+wGFu5DNCkOaxOcilb0NOu6Hlnttt+Pve3DAE71o=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Ik8J2cvl2N3yr/fMPJoIAqtJA52qc/KUog9RPF3WGU+wNy4z+Fj8TFJD75ILD2mI4
	 OCLhmRm5qANCdOKeS0NjsgdkaIwyM8QdQWFhX+XhlnFKST2Bb0N50sN9MYjjFmGJWO
	 0r4QkcCs/VzFlW09FDUJM1OAUnRo0o+D6ds9AuCOw+6nN7yx29leq8WBpkUHgX5kqn
	 bbjt3jKkrJDyIuHyBdBUNzlPBcFRROa5CrOAhaSeAGgxW+mZ7EPho7FU/Rx6kDLQih
	 JgqwydSp2bfCzaeGeZk1aobPCU1nM6D5YTN35IKVnC8cm2mdzvssV1eVnBB41QLzad
	 XigxbSULGxoqA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oppo.com (client-ip=40.107.117.85; helo=apc01-tyz-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=AHCjiykp;
	dkim-atps=neutral
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2085.outbound.protection.outlook.com [40.107.117.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LzC1w3BnMz2xGM
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Aug 2022 01:14:26 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9usq4MCwHavf1TVUYxJTOhPapBal5+BvDHZC5Tb6QDfqI8fcRp/z+lKaO7v5IViRfQuksMXfvgFau1ciMadQ3pRZuYC4vAG1QKS5xCIrhn1CoD05JQpWg1vmPK9jHZ97PbJjhdHB99MJ5SUCvHLAl24OY5qLtjniiMVAH4xyYiaiuf2ggX3eRYqrlvNWVmjatNt/wpzb6b50qXbZ8uP86h+s7iyZ+z18/M9xL+VUzOE6Nkpnj6cusZ+RoU/TzsOaWQ7ZsMDbcEA1ukrzll64fdLls7u6R5hlkXu705Ox8EGy0h0qRrwP85dac8DnUGKnGq0grNAlDUM9rPJak70zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fu+wGFu5DNCkOaxOcilb0NOu6Hlnttt+Pve3DAE71o=;
 b=HTatRrHhqdZRicS8SM2tT/mMHfIkEujaT0BH7Nu81vWrywd8Y0U72SlALzg4LqXeXipIKQR8ws1fLDl/skHxXRnoOnLOH5Q1shWwFIq2TloAOZm728/PX2POQVXO29PYr9PR2QhOHjcKlshmECYDtqMmasEgnqQIApP2T5n5tSUmFQFONxZX7rrAwVITq5lEn+c1gF20gdMt+OLG8kueaifM1+QmAneqow5HEEUqpaZWRfkqVc+FUJiJQjImwjVGOHYsjz4hiVpSNsJF+62vF44l4hmSrjhTW5zlNet4dI27seJkUf5nVSS8EEjb/YtQ5c2BdYgruFDGTM0rdDb7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 SEYPR02MB5847.apcprd02.prod.outlook.com (2603:1096:101:3c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Thu, 4 Aug 2022 15:14:05 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 15:14:04 +0000
Message-ID: <d783aec4-4d1c-46d8-202e-27ae5fe3cc72@oppo.com>
Date: Thu, 4 Aug 2022 23:14:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [RFC PATCH 1/3] erofs-utils: fuse: set d_type for readdir
To: bluce.lee@aliyun.com, linux-erofs@lists.ozlabs.org, chao@kernel.org
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-2-shengyong@oppo.com> <YurPyAkkaHDD4Lih@debian>
 <YuvflEoj8S9ddA2w@debian>
In-Reply-To: <YuvflEoj8S9ddA2w@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49006b2a-4e81-4434-1079-08da762bf845
X-MS-TrafficTypeDiagnostic: SEYPR02MB5847:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Gvw56MCrefFFkZkNaIjm8zkE4Xg8XEtU1NopimazV77Pqtk70UtaPL5uOUIX5FwQN36fsVHyLgzuSjSIQ8iYw2K9IYCIj7SyIAujQxA5+c62qWaqC6HV1IUbZFivMKP7hJ3XVRfayo+G0mAwmBLrij/gOyKPSKVMkVwT/mwHb9X3ligRaZ8v/meu1kLOmXHlTwDUYqPCLIdyY5O/fZG0gNRG2dOoH2Qnu81q4UJtBXVblv9POd1PhvOxg0v/AiWAw3+b6dlqjMgBrcvwefEUxb9H1j3dfwqirQ18PtLeVfdgU6i6g19D8tZYmp/IJwdbzFWUqb4js8PA/cHNSS3zCkLaoJF+wD3BkP0IkdC+uVviL0KuL0xzSZdhXPowkHsOT9gU4UqAQ4bjnxPDfmtwcRNo2rIzEsxeMPcVqaL3mg4SujqDqWExaFWF0g+vdLzYqvwhfC0vqIQkGC6xsbd3e79XzrEvYNqxb01P6JP87Zuq9BYFEKxfb+t4tlmQ2FEJisPY4RX5Svryhk7ma4S7Zmpw4zN3BcA7nFgLmLtL6q5bCS4tIhjWyt4I4+DlOxH4vPssyt5ybLQHsxQz6xlMTPqGMzZSBTF/VrG2GmRguSBkHQ50w3d3yzjKXCSRsnL/hrWPZgy0Nzuiy3Gy+e9kb3JBblGFkRxa2Iuq8H0+6uNtSWRU98rIIpeaZBbEed0u+QIv18eK2Ry1+NKsim+LGOvDhUvbbaWaPLVNAK1o3M+dEkSzyB6NOLixvTuJstBpA0zL+r0K/nQBd1cls9ghdxlsGt8DnD6D6kHkdjLJFhVsLdfi1WvDADpAYVnRYpsn1pcKeVc/spBvb8MRWhNqG0wJAJ98PbJNNL8jrFpWVjc=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(31696002)(6486002)(478600001)(5660300002)(66556008)(66946007)(66476007)(2906002)(8676002)(31686004)(38100700002)(8936002)(38350700002)(26005)(6512007)(6506007)(6666004)(186003)(2616005)(52116002)(41300700001)(86362001)(316002)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TzRLVmYrS2EvNVVCdFMweWJDbmJWeXpOd0VhbFZzdVFlMmN3QkZSRjhuRDE2?=
 =?utf-8?B?RG1KcHMyV0dYeEJKTTd1anc3TlJTZTRQQU4yTFpqSFZERXVWOG5ZTDMzcm1I?=
 =?utf-8?B?ZG8wTklzOGpKSFBDaks3ZW5zR3BqODJxZy9UYWJ4SkFEeFBPaWtNRVFZRzVS?=
 =?utf-8?B?QkZkT0h6czVMTmJEL0Jla08rTFUyM2dMcHYzQUhoeE10RkZsandHdkUzMlB3?=
 =?utf-8?B?SjIvZEUrRmt2Z2ZHRlI3dU9STDRGMDc5NnFleXZ3OWFMd1dUeWMyUXRFVk45?=
 =?utf-8?B?Y1BlWVRoOWxYVGdoWDM3K212ZFF1b0xOMUdsc3AwUTZscXZrbSt2dEx2QlIy?=
 =?utf-8?B?M2xKTUxvRndsNDhDNGNTRmhFeDd2d0dFUmtDOFZmMVdHMXJaYkFORlh6RldB?=
 =?utf-8?B?QkdRRFJ6ZE5XN1hvYU1haUorRUp3OEQ5bnRQaUIzcTdMa2p2YkFzK2NTT0pS?=
 =?utf-8?B?L3QwQWljd3VySHE2TjJDV3EvRDBpT1NkUHhQUjBJaHYwNFZNVnR3aGhoUFUx?=
 =?utf-8?B?SjhuN2pISVFyeWIrODRRdVdJYUxsNk52TjRqN0lza3dCcmV4THhMOE80MDg0?=
 =?utf-8?B?ZkIrdU1uV2MrRlJCeW4zaXduNng2eng1dlJKRWJndXlHWmw1cTJNOWpsYU1O?=
 =?utf-8?B?MUZYYUVNdXNid3creDVGZ3M5WjdyWmloUVVSZWdhNTZSZGwxNUtXWUh3c3NH?=
 =?utf-8?B?NyszVFJrcVNKMjhMSjUvcHRFRVhEUTE4S3oyTnJYUStYZm5NTUpOUjdnanZG?=
 =?utf-8?B?TnJMYVVQZkJadmJMR2g2b0I3VHlXYUppMnAzT2dsTlkxRzFld1JnQ09DamdS?=
 =?utf-8?B?QjBGY2tVeHFXb05uVzhzMmpjS3V6djRJdlJIbDVWUzBhUDkwMmhQUmFCQzhN?=
 =?utf-8?B?S0lLQjMzeTNjck40YVB6clN4NmYySUZqRERCdVdxam8vNlJUcmJDclBaWktZ?=
 =?utf-8?B?MWJPaW5kakZ6bTF2K3psL2JKcHRBSWdEQWwxWEJnR3ViUUVCTFNKaUExd3Q2?=
 =?utf-8?B?SEh3bCtDYzEvanFtOXhNSEE3cHN5N3hLTlVGVDJTVHB5dzFiWkpodDBEVWFI?=
 =?utf-8?B?b3RINTJNMU9mTi9nWStqNzRFNTZBeFlTMElCNE5Nb3RuRkQvaVNpOVlSUlBm?=
 =?utf-8?B?dDA2bzBWN2w1SUtMeVJNd2kxZUh4UXJneVAzU0JuMHlHNk1PUkZGUkpPUHVH?=
 =?utf-8?B?eHZ4K21mZGpDQW9yb1VjcnVqMnJWcTlSVno0V0FIeUs2SkovZkJBcU9QTkFv?=
 =?utf-8?B?VjdFVHlJdFMzdWU1N2ZleGpMMktkMWtvY2UwNUJ4OVRVUDJaRkRmeVhucXBj?=
 =?utf-8?B?QzVtckZhQzdwN2w1UnNCY2FEQlkyWkVhWUZYNVRqSmxlZlp4ZXM1UWwyZ3dQ?=
 =?utf-8?B?Mm9EQllOODJpR25XZEZQbk9MaGpEK2NLM1hSVzBNK3h6eXl6VnowN3Q3Wk1F?=
 =?utf-8?B?b0FCR0NRNFZJYWx1VmxNMjdhbS9kbUYyRmNZWGxNVXd2QUU4NmF0bkxWTmtC?=
 =?utf-8?B?ZjJRNklDOTkvYWRtWUVsOFo3eUdYVWJvSFF5YjhTWkVkL01QbEdva2VtVUpy?=
 =?utf-8?B?MnQ2UGhqSjNZTjk2NEtRUndDL0oxbUdtVzh1emQ2cTZQVUR2Y1p4NmhWVVdE?=
 =?utf-8?B?TjlpZXpqbFFtU2VPei9SbHVTOVc2dGU3WnI2TnRJMVhodVc3MmpIQWFqQUxD?=
 =?utf-8?B?QXpBc2FqY2hhci9wYzY4eXd1TGdWbHZ3dm8ycmU2eVZzYmxIczNyUDRMUURI?=
 =?utf-8?B?c0hzcVQvOUNHbDdDVmdBVkd6aVFSZGNmT0VEVU9EN3M4RGM0K0FTTTVkcmVn?=
 =?utf-8?B?K0drMU0vYzhnNVNqcTdPZitNWmR3WG5uaGY1TlBCTVUvbkdZSmpYNW1UazRk?=
 =?utf-8?B?NktFSE82a0o1cUhIKzE3MzdkL3NOMFNhcDBzN0ZKay9mWVNmOU8xUm12bU9Y?=
 =?utf-8?B?MVQ4UTdiWkh6eXFTM3JaRGI2N2NnRG83NGQ4RyswRkZvdHNwS1NNeEtDc0Vj?=
 =?utf-8?B?Vmh4d3o1R3ZCK0IrZWcwQjFrUllSOWZENTF0NzdTVDBnK2o1S0hic0RIVWdn?=
 =?utf-8?B?M2pTLzRPRVphem51V0l4bWo5eG9PU2FYWExMamthN3ViRDNnS3pmUjM1eHE5?=
 =?utf-8?Q?Cfh2PacD2v/3JtXroS1Hdeuog?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49006b2a-4e81-4434-1079-08da762bf845
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 15:14:04.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUOpxcVZa/MHXL26lDNujtkF4wZ+V1y2VsYbbLHpTpRxfJGPfoIZWl+lhDx3f/Tx9fm+pla8ErXt6nao+MTV9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5847
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
From: Sheng Yong via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sheng Yong <shengyong@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



=E5=9C=A8 2022/8/4 23:02, Gao Xiang =E5=86=99=E9=81=93:
> On Thu, Aug 04, 2022 at 03:43:04AM +0800, Gao Xiang wrote:
>> On Wed, Aug 03, 2022 at 10:22:21PM +0800, Sheng Yong wrote:
>>> Set inode mode for libfuse readdir filler so that readdir count get
>>> correct d_type.
>>>
>>> Signed-off-by: Sheng Yong <shengyong@oppo.com>
>>
>> Reviewed-by: Gao Xiang <xiang@kernel.org>
>>
>
> I'm not able to apply this patch since it's badly
> space-damaged...
Hi, Xiang,

It seems some invisible characters are inserted between spaces.
I'll re-send a new version.

Thanks,
Sheng Yong
>
> Thanks,
> Gao Xiang
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
