Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB21A165C4
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 04:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1737344614;
	bh=BzfD3rROyLf0savlrjPPPIIsBSch8uDyRrtUJTowPNY=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VtLlS5xmQ8RfjjTcRDeBZ6dxlPW5PVby+VLBvOpA2JkjCP1VEu26VGEObfxLhnkRb
	 g0uiz+N4/cDuTJFxCbpurzWAUUJUSimSZ1ZcFaVX82d2k3ynPkLrEUZy0zxLf/jUyE
	 01+GEIxAFHt72lwGxJQFxjF2t0I28NkxjuuwUEvd9jE930pdZsWu2YkXmgNhiW4trt
	 k8QUeOR1LPPXr/zBRQJNZmStmgPn4LhdlJykg1h2wKfXCdkHB3JQpnh0+MVawo7w3e
	 W5pKL8trNGSsVFMk7zoHzraMD2VEP/k7Medpc8TzKps1cQT0ogSd2PsgXkuBZh9PjE
	 UZOSNYZIY6CoA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ybx5L2Qv4z301B
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 14:43:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.35
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737344612;
	cv=none; b=J+l7cqmcC/6wTuKhlw7Cw69hZZPnVTKf0Ltj1OFo3r+Oj00wQ0n55gmwA2Q1ZAGWGqsWJsb6GEi6iGgcjTuO5GR0Antc4AQlkQ7CVgu2aw6K+q2Fxu9zQGDzWHar/yXwONP+1EzhI4Hqd+7mPAILzb8tMWSd229ZvF9cIKNv8Cti+a56KZyHi4yF/1go3+Iq3zr3Br+Wsk2z+vEsMtj1Q5JdVDHQE7AMgTPyo3GRzlr/mW4q/11cCufel3jQUo5eumhVR4cMa1smDEsfr9gHgxS/gKzz64puNqWGraW30EWqdjKpqMgPe8T7NvVfCp/IGVXRQ64URjexceDYF/OGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737344612; c=relaxed/relaxed;
	bh=BzfD3rROyLf0savlrjPPPIIsBSch8uDyRrtUJTowPNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GqtsKJaQlIiCvZSR2yG54dRropfYRiM3ZP8pb/R2D55CIHjoanooIhjl+aB2xl/8czsQKWcSUrZ56bxjXURoL+0+XbnjbTOTPaX17n7e3sjXd3ZvnCNKazBFPVn+ONV2TEcA1qn1vUp5UMgiV+HvgnDtGKHokVw9a4DEyfJiYsFkbZjhnI0rOYQP5wXwRd4gO9dqJrjmpbuPLRw4Ywufg1CFeZ3npwp1th5585++oxHP+9tUfMC64HV9kZ1ZXvfR+en3JiAg3ni1Slei8qe3/e1NdHsoEIcUatOsKC8FLVlcRlWvkW9lyCR+V0pVgAYGESfYANagAQG+tcJP+OvVtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ybx5H0xxfz2yFB
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 14:43:29 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ybx1L186Tz1V5DR;
	Mon, 20 Jan 2025 11:40:06 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 056801402DA;
	Mon, 20 Jan 2025 11:43:23 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jan 2025 11:43:22 +0800
Message-ID: <dd9beb64-3bdb-4f49-a94b-21c039325558@huawei.com>
Date: Mon, 20 Jan 2025 11:43:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
References: <20250115070936.119975-1-lihongbo22@huawei.com>
 <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
 <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
 <f0a6b66e-0427-4c66-8c69-20c6c362e55f@linux.alibaba.com>
In-Reply-To: <f0a6b66e-0427-4c66-8c69-20c6c362e55f@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/20 11:10, Gao Xiang wrote:
> 
> 
> On 2025/1/20 11:02, Hongbo Li wrote:
>>
>>
> 
> ...
> 
>>>>   }
>>>> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct 
>>>> kiocb *iocb,
>>>> +                  struct iov_iter *iter)
>>>
>>> I wonder if it's possible to just extract a folio from
>>> `struct iov_iter` and reuse erofs_fileio_scan_folio() logic.
>> Thanks for reviewing. Ok, I'll think about reusing the 
>> erofs_fileio_scan_folio logic in later version.
> 
> Thanks.
> 
>>
>> Additionally, for the file-backed mount case, can we consider removing 
>> the erofs's page cache and just using the backend file's page cache? 
>> If in this way, it will use buffer io for reading the backend's 
>> mounted files in default, and it also can decrease the memory overhead.
> 
> I think it's too hacky for upstreaming, since EROFS can only
> operate its own page cache, otherwise it should only support
> overlayfs-like per-inode sharing.
> 
> Per-extent sharing among different filesystems is too hacky
It just like the dax mode of erofs (but instead of the dax devices, it's 
a backend file). It does not share the page among the different 
filesystems, because there is only the backend file's page cache. I 
found the whole io path is similar to this direct io mode.

Thanks,
Hongbo

> on the MM side, but if you have some detailed internal
> requirement, you could implement downstream.
> 
> Thanks,
> Gao Xiang
> 
>>
>> This is just my initial idea, for uncompressed mode, this should make 
>> sense. But for compressed layout, it needs to be verified.
>>
>> Thanks,
>> Hongbo
>>
>>>
>>> It simplifies the codebase a lot, and I think the performance
>>> is almost the same.
>>>
>>> Otherwise currently it looks good to me.
>>>
>>> Thanks,
>>> Gao Xiang
> 
