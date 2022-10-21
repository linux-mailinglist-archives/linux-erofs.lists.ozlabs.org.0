Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0A8607182
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 09:55:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mtxbq4kvKz3dqr
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 18:55:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666338951;
	bh=fRACIIBShcs17dxhNMHJKvpK8tgIULqC76X2wJf8Or8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KjGy/PaVbU3WKptOmmddrpMYIFcPfX+rkFtZ6CN4Y//cfiwKme2Eu1ceDnnba1eJW
	 GRmLLHNYL5iwywG5EaJC9DMJm0pDGcG3+e0HaFVIIqr+H8ff01YWQGa+VN0meVvCCn
	 Fatbz/fFxQwaBSYadBFQit10vlc4O8bHQY/Hfsdzs7gYvcIH5QVtDt197wTqHQ79Uj
	 ZWgwy9V8ybKviA05Js3zgnlWxO7XDu8DkzkLgCp5aycUIGsO/2OgFTF+VdkYQBR/2C
	 aH270dK2HQrJGognNdE3hYE6blCeZuzocwaKLlpEPteUzouLib0F5ddjtDVdY3mCvK
	 YYPP51iHo4Gyg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.243.70; helo=nam12-dm6-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eu5aPyob;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mtxbh4wQGz2xJ7
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 18:55:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATvZqhoNDTgmQDjui9UdC6sQJmcgaupRemuya8Di5wd6XtS9KLKhy19vpu9aUDTvmybdL1vLkNUDQsSV+s8GQQQlg2AF/TNDW22MUbQf9xUOQnuXsghTsg8fEn1uZeM9x6OeFYPJLWZZGgRj2OWl2Sei9MLnhbyiPR7ZLTE+mHNZI7hvKbuHgM3PHc0+vFdWqSyVekXY9RZAjfJIvtlBFRMqFz10UQWscVtDpDLyY296XHSbnnSIso6iTJ1uJpxb/bvvHSrlWFeI+HhxH7MkMgoPOk6dF4kDOPPYaYokWAd2aBK5/mOg/bsukj3AvlBFs3V8O/Fbb4+qyWd5rHeyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRACIIBShcs17dxhNMHJKvpK8tgIULqC76X2wJf8Or8=;
 b=nJVNZHhN8ycmpPVh69If9/Kl4T/A6A2qO4ux8e7w+Vp3mDpa+A274zroG4rNu3IVy3ZHGqstn1pattRlWlK0ebUmBMsoX00S8Y+AJowy0muds5d1hbYen/z6RLrCsrcuBNplGHV0OkqK12CAYq3REeLmtVVKXYROh1QBSGLWRzFntKQpU4GHMzKD6eA8aYTNLs7TUV1bm2sf8wCy0lxcLebGhgH8mBqDlx55epRqbmYzTQgwuGQy+LozB0rM/1s2dRDMPF/YBDUGEhB4QKnyUkFFSNyWkt6GqtLQMSG9upmaoWIyL6NFCIhRJfnorY4vbZUsIsgTBCehFv0m2CidUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Fri, 21 Oct 2022 07:55:21 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 07:55:21 +0000
Content-Type: multipart/mixed; boundary="------------9VtOs3mF29K0mdP7SyPs0VFr"
Message-ID: <5efd73b0-d634-d34f-3d7a-13d674e40d04@amd.com>
Date: Fri, 21 Oct 2022 03:55:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Content-Language: en-CA
To: Greg KH <gregkh@linuxfoundation.org>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
In-Reply-To: <Y1IwLOUGayjT9p6d@kroah.com>
X-ClientProxiedBy: YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1e6fa5-9788-4e1f-24b3-08dab3399a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	okpt7L5SEG56woasM5xJeTJ1nidp7lS0w9DZdMiCIOImiXifT4iHjbmrbqsztJz4zIZl0xeGE6jPoP8uSkPjNxnwUR1WyJ9EQGKLMxhMy209JndaDT6YchKwFcKkeM0j0aZBdJ2ZcAiv536fIK5NNmbGPM3tuZgT4FXYdZb8xjeymm0cy3Ec7zt6VcB7zmL1i1pTvz1abLWF2PoDRw+aSFKEw2OxW6okijr9Ihe1kt+84UQBqjIf9NqPVLXw7a2AfF3nH1UXYlrjs16ACWMQ5I1EOQx84UUiCOR2/QLkjmb4oOYyd+L1lxzqJFofg6MzeOe54GFfQULXEa/2iIaUTZIRvSqL1LeRoS1AkpwXqffdbqB/NTFJnN0PbY7wK3xEREA8Idr7Gi9sWXqOka77lRvh+0NrOPtHNo89LjiQeEEYT42+yPJBfyVBJsQtetGTFSOluhOZe9C7YyCHSZJHP1Ufe1F3zINjORwcuU/Ykc/h8xsY8lXOzAtlvL3tFcP1WGMKOPlT+jTv9Gj43vaelaXt4Z3nagLOjkN4hM6qPyIySJvcQGfvJZQj71nTqUW0rUHMfwEjovtKNU60CW9pyctGyrFTIWhKHdynLnGNbOjkmbomH/hWnIPg4+7Zcx+Jb0Z1m/WJp8CP+yENn7B7kb78UCii0bRhNp0zC9LqwaNGfucS56PpIlFZjz2ozr3MZFSaBzaTF5/6sFQXXW/q73GKDFRt0axqqYtwyFfAOMK87rcqDgrzQKcdShi5zLoqWpx/UyplcaUh9MxS3FONN10HoIa70t33tjg+V6u43L5Hq9d0HeBmBdLitvxOMaV19LbZu1E9jnHTdHwnGQU2vA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(478600001)(6512007)(26005)(33964004)(6506007)(2906002)(6666004)(186003)(5660300002)(7416002)(2616005)(53546011)(44832011)(235185007)(66946007)(4001150100001)(6916009)(8676002)(45080400002)(966005)(6486002)(8936002)(4326008)(66556008)(41300700001)(66476007)(316002)(66899015)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?dHpQLzVNVFVFak5yTTZvbTQ3c0pEdi9Ob1p6MUVJZk1SWjJtNXpLaTNTOTJj?=
 =?utf-8?B?aVVIT0dnbExDcjczbnpKRDluY29UZWhvNmVrQUhwT25GclRnSEdhMDZYT1BX?=
 =?utf-8?B?WjkyY1cyMFpTWXl4RWF3cmV5R1VYNUcrcmt1U0syaVkzQ0NvZGxUT0VkaVdn?=
 =?utf-8?B?WDNKbnZrdzRyb09ScFIrR1lsNGJ3cEQxZi85Y0d1dUpFOGdkdkxVWDR1RzJo?=
 =?utf-8?B?S3pIbmNWV0NoRGxZWXd4clAxU1ViUnFQNlBnK2Zybjg3T3JVMk13Qzdka3Jh?=
 =?utf-8?B?ZFg1cDlsRGlxM0ludnZaV1A2NlJjVE83U1p0UmhOYVprUGdpbmVxNFpjcCtJ?=
 =?utf-8?B?NmV1aUVEaVZIVDhDMlk4ZEZxMWd4MEhCK1lBRjFsUUFNTWUyc1FNRjdzaDZ4?=
 =?utf-8?B?MTNZQ1RjcmVqck1PeENEd0tMTXRrSnd6YUQrTlBpclRSQ2ZJTUtuc0VhL0ZN?=
 =?utf-8?B?R0k1TURRdmNScWpZYURNQk1oY1I4dFJ6aWJNR29icWl3ajEwUHUxMkkyNTg2?=
 =?utf-8?B?cmhsc2JFcmNEVWVQODhiWFh3eDRXdGg2SzlNZXZ4MnQxU0MyLzYxU2xmZGVp?=
 =?utf-8?B?MDhoRGppZG9xanlDb3BHQjlSVWxHZHVLZjJIQlplNUMvVWg0a3RiTFFGUlBN?=
 =?utf-8?B?Y2dKUlZIQkc0M0krTEdZRFRCbW9GTWZObTZpNk1vaVVFNVYycXg2cnZPZWdL?=
 =?utf-8?B?dmc3VVRmalBNRTV1c3BzS1lQZ0kyZTJFVVVJM05RbGtrekdoMyt4NlliWmo5?=
 =?utf-8?B?ZmdEMnFwOUFiak43MWNZWk9nVlI0amN0R2IvOGhEa1FFZ0prVFNnaVlVdS8r?=
 =?utf-8?B?WGFiNjQwdk1VSkFRMTBxRmFuNSs0eEw0SlBPaW9VN1NqcFNDRDRZK09NZ0pn?=
 =?utf-8?B?Q1l4Ny8yd0JDb1J0VlhPY2hLRXJ3MGN3S255a0pMTjNyKytXeTk0MnJaT0tq?=
 =?utf-8?B?QnJxMWNxdTVWV3Vlc2N4aCtnenBnNjBJZmcxenFNYnFFbk5OWURQWFJpbWJC?=
 =?utf-8?B?ckRQUWVCeXp6dTljQ1Y3ck9LNk9qZ1lrK1dtSzJPcmFMV21EMWtiWEhIcFZC?=
 =?utf-8?B?ODZVa1d1NjlTTDREazRqUVo3RXdxai9JQTBCb25VYU84NWQ1QnNxTCtJUXBl?=
 =?utf-8?B?VGp1Kzd5T3NBOHBqRmQ1eU5adkJyMkdseHBmcG5sd3dqNm1USkhtZDVCa0xy?=
 =?utf-8?B?azlUSGw4RUQ5bUVTKzdUNnNmNWt2U2gyYTNLMHRJNU1OQzF2cmxZUDU1Qzly?=
 =?utf-8?B?OVRIUVpoL3JSenBVZG1QMi9UTDJQWjd2bTZRZzkwMWtHM0s1eHNZNXNBMENt?=
 =?utf-8?B?REg5UGRHRDNSc1lUMDdNWXdKeUJZWG4wc2k4MUg2UFd3VU5ZVkttM2dtOXJN?=
 =?utf-8?B?emJuL1BCaWFjd2MvcjdJSmJPaS9jc1dUVFUrKzVtR3pSK3ZKUk1QUzc1cVpO?=
 =?utf-8?B?bEFiWVViSXQzTnM4SkVoMTkvcm1VWTB5ZkY1ODFhOCs4S3FmRDNRcEdEM1dh?=
 =?utf-8?B?dVZCc2VIQ05BeXpCL3l5TVJXeE9ZZERYeTRRUGFTOUZzL1duNlBoMHMwMnZr?=
 =?utf-8?B?eEpaV29scDRZYlVFcGcyMkF4cCtqL3o2ZUwrTmpDc0szWGtOZVBrZnovdUxm?=
 =?utf-8?B?N0J3TUlqRnV2UUxINzRuVWtwZ1dWNHU5UUZlNGhWMktzUngzZkUrb3doNktH?=
 =?utf-8?B?K0dpa1BZbzl3eExnVTM4WS9RWkhyck56MzY5OGlUMm5LS0ZzLzRZdENoR2ZR?=
 =?utf-8?B?azVwVEtKVUc3ZW4wVHd1VWM4SkVFRXJwazZEUS9OR3Z2dDVDTzdzakh5OXpo?=
 =?utf-8?B?WmJWL2d3aFVDUXRKT0t2Y2k4WHV1Qk5HSytoWHdSTXRTYVFtMmdJcExuSHJo?=
 =?utf-8?B?RnE2cnZjbUtmczlmZEYrYmpGaHVXUHhjWEM3WkkzN21jNU5iM1k3OUkwSWhi?=
 =?utf-8?B?RzNmYzZMcVdlV2xvd1IrMTFMOE5qOUVZdDY0ZlFEZTR4ZGJZUnk0R3pGVDVx?=
 =?utf-8?B?VFB0NmhMQkkyUTlFVFFaTTZnYytac3Z0UzRpNFBuZWFvZjZKMi82Q0k1Tjcv?=
 =?utf-8?B?blpqckxoNmhHRXJGZTFjZnJtVmhMMGtOOTZyVkc1RnJ1Q1lqU2tYZDZpVXpB?=
 =?utf-8?Q?rHD4keo7VELYlXoW8XTJnROxt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1e6fa5-9788-4e1f-24b3-08dab3399a5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:55:21.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qc+2mMOM8ktWZqlUNOqGC2E7s39vqX1JDZkziPRqfJoYgYiV8bMo9eH7CaE+4Pc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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
From: Luben Tuikov via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Luben Tuikov <luben.tuikov@amd.com>
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org, Yang Yingliang <yangyingliang@huawei.com>, hsiangkao@linux.alibaba.com, somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--------------9VtOs3mF29K0mdP7SyPs0VFr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2022-10-21 01:37, Greg KH wrote:
> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>> The previous discussion link:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C65b33f087ef245a9f23708dab3264840%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019274318153227%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1ZoieEob62iU9kI8fvpp20qGut9EeHKIHtCAT01t%2Bz8%3D&amp;reserved=0
>>
>> The very first discussion on this was here:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C65b33f087ef245a9f23708dab3264840%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019274318153227%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=9joWxGLUxZZMvrfkxCR8KbkoXifsqoMK0vGR%2FyEG62w%3D&amp;reserved=0
>>
>> Please use this link, and not the that one up there you which quoted above,
>> and whose commit description is taken verbatim from the this link.
>>
>>>
>>> kset_register() is currently used in some places without calling
>>> kset_put() in error path, because the callers think it should be
>>> kset internal thing to do, but the driver core can not know what
>>> caller doing with that memory at times. The memory could be freed
>>> both in kset_put() and error path of caller, if it is called in
>>> kset_register().
>>
>> As I explained in the link above, the reason there's
>> a memory leak is that one cannot call kset_register() without
>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>> in this case, i.e. kset_register() fails with -EINVAL.
>>
>> Thus, the most common usage is something like this:
>>
>> 	kobj_set_name(&kset->kobj, format, ...);
>> 	kset->kobj.kset = parent_kset;
>> 	kset->kobj.ktype = ktype;
>> 	res = kset_register(kset);
>>
>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>> by the common idiom shown above. This needs to be mentioned in
>> the documentation, at least, in case, in the future this is absolved
>> in kset_register() redesign, etc.
> 
> Based on this, can kset_register() just clean up from itself when an
> error happens?  Ideally that would be the case, as the odds of a kset
> being embedded in a larger structure is probably slim, but we would have
> to search the tree to make sure.

Looking at kset_register(), we can add kset_put() in the error path,
when kobject_add_internal(&kset->kobj) fails.

See the attached patch. It needs to be tested with the same error injection
as Yang has been doing.

Now, struct kset is being embedded in larger structs--see amdgpu_discovery.c
starting at line 575. If you're on an AMD system, it gets you the tree
structure you'll see when you run "tree /sys/class/drm/card0/device/ip_discovery/".
That shouldn't be a problem though.

Regards,
Luben
--------------9VtOs3mF29K0mdP7SyPs0VFr
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-kobject-Add-kset_put-if-kset_register-fails.patch"
Content-Disposition: attachment;
 filename="0001-kobject-Add-kset_put-if-kset_register-fails.patch"
Content-Transfer-Encoding: base64

RnJvbSA3MWUwYTIyODAxYzA2OTlmNjdlYTQwZWQ5NmUwYTdkN2Q5ZTBmMzE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgpE
YXRlOiBGcmksIDIxIE9jdCAyMDIyIDAzOjM0OjIxIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0ga29i
amVjdDogQWRkIGtzZXRfcHV0KCkgaWYga3NldF9yZWdpc3RlcigpIGZhaWxzClgtY2hlY2stc3Ry
aW5nLWxlYWs6IHYxLjAKCklmIGtzZXRfcmVnaXN0ZXIoKSBmYWlscywgd2UgY2FsbCBrc2V0X3B1
dCgpIGJlZm9yZSByZXR1cm5pbmcgdGhlCmVycm9yLiBUaGlzIG1ha2VzIHN1cmUgdGhhdCB3ZSBm
cmVlIG1lbW9yeSBhbGxvY2F0ZWQgYnkga29ial9zZXRfbmFtZSgpCmZvciB0aGUga3NldCwgc2lu
Y2Uga3NldF9yZWdpc3RlcigpIGNhbm5vdCBiZSBjYWxsZWQgdW5sZXNzIHRoZSBrc2V0IGhhcwph
IG5hbWUsIHVzdWFsbHkgZ290dGVuIHZpYSBrb2JqX3NldF9uYW1lKCZrc2V0LT5rb2JqLCBmb3Jt
YXQsIC4uLik7CgpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4KQ2M6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4KQ2M6IFlhbmcg
WWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+CkNjOiBMaW51eCBLZXJuZWwgTWFp
bGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBM
dWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgotLS0KIGxpYi9rb2JqZWN0LmMgfCA0
ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9saWIva29iamVjdC5jIGIvbGliL2tvYmplY3QuYwppbmRleCBhMGIyZGJmY2Zh
MjMzNC4uYzEyMmI5NzlmMmI3NWUgMTAwNjQ0Ci0tLSBhL2xpYi9rb2JqZWN0LmMKKysrIGIvbGli
L2tvYmplY3QuYwpAQCAtODQ0LDggKzg0NCwxMCBAQCBpbnQga3NldF9yZWdpc3RlcihzdHJ1Y3Qg
a3NldCAqaykKIAogCWtzZXRfaW5pdChrKTsKIAllcnIgPSBrb2JqZWN0X2FkZF9pbnRlcm5hbCgm
ay0+a29iaik7Ci0JaWYgKGVycikKKwlpZiAoZXJyKSB7CisJCWtzZXRfcHV0KGspOwogCQlyZXR1
cm4gZXJyOworCX0KIAlrb2JqZWN0X3VldmVudCgmay0+a29iaiwgS09CSl9BREQpOwogCXJldHVy
biAwOwogfQotLSAKMi4zOC4wLXJjMgoK

--------------9VtOs3mF29K0mdP7SyPs0VFr--
