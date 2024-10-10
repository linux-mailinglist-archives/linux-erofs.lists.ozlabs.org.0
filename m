Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3E998484
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:11:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728558685;
	bh=R408GbKhkSKZGo94FC2v2vy0sr9rsMgrfGuJNw0elU4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=orqijepudDMQDDXVrIetWO6VyoBjXhpZie7KURZ1CyrAhNvFvlg8Uxo9g0K1pOrae
	 aGUBIxGXM9PRT/ccyr/Ywu0S8OdyEJutWvhXYOIHagJbZU8RRvI63FOG6832IJCiWG
	 3gs1qTWxGKBDLEKY2BcWNy3XUWZcqK3TQjf0BkWRPSUA1J0kRpYB/AV4zLsov14g7b
	 uSyhjODvgQkSe5L4ui+/OkxEm+8ch9skVT0pC3Q42VDE2hLRR/FamMNO183ri4J/qN
	 znDRW9WXin6kgA+CvbtNiincbgBk+32wRzFlSk23vy3Rc3f9WjwiHLnpCqagOBFlHs
	 EpNJeX2MBWvAA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPRs92w7Xz3bjb
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:11:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728558683;
	cv=none; b=PVJFts+TuatL1Ggn/UPJPFe0sAVoKBjrEpBGt8joCn6v9mUug+1Y0CqBC4TIbIP4JAcLYZdkbxOsTv9auq9ZvYggTYyoJw07U37U3VoCU1jnWsetMO5QSap8YwOLCS4Sg+4WyTITlsZ7FdZXbEiy1zuNI/lUrdY9yUgtp8Z4amp/mT0sbRu+cQfcGzsYQOCA+xmc23V2YBoWwQEl2JHzd5Y8I49y9FpkmjM1Tt7U8PSCWQk4iOJObSSV94aoaBHQiGzeAzEGryk2OucO7uiirK+yVQLkhzV9HIx1b2PQpeFGhf6zbOpGKorjPf035GiGhSszp4CpP1G/Xs4FCSKcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728558683; c=relaxed/relaxed;
	bh=R408GbKhkSKZGo94FC2v2vy0sr9rsMgrfGuJNw0elU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P1C2TxAGrwh6G11s5Jhs6h0sZDrOOmonyKnKZGEHZNkW1RcHuvDQi/9iyPpoD7n3GP8HVonUY7F2BicfMGi7pP89EABF1HJ7b6yG+7vC2jbLq2zUcEuR0EK8A0lXwRlhSHmy02jeXgE4Slc8N9gymU57woKza5ZfQSoa9dhRUZlLLgE3zZI+dpAzta9JCNXXUMd297oks8xbW+/aXvvUYPFWiFvDb7i7KKsIO9N0ZBRasuYQlQXdwtuWPy42uMdRfz+wbcExkVyOVpXseulQXBrDu+0GrGS1inp0xyBvVZXqd81IEQamXhiHvzypIz0OrP+zo+wDHxkDOPym50wOmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPRs53hsPz3bcJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:11:17 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPRp76M00zfcmb;
	Thu, 10 Oct 2024 19:08:47 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D1C0180AB7;
	Thu, 10 Oct 2024 19:11:12 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:11:11 +0800
Message-ID: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com>
Date: Thu, 10 Oct 2024 19:11:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in
 __cachefiles_prepare_write()
To: David Howells <dhowells@redhat.com>
References: <20240821024301.1058918-2-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <302546.1728556499@warthog.procyon.org.uk>
In-Reply-To: <302546.1728556499@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2024/10/10 18:34, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> In the __cachefiles_prepare_write function, DIO aligns blocks using
>> PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
>> cache->bsize with the requirement that it must not exceed PAGE_SIZE.
>> However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
>> count will be incorrect in __cachefiles_prepare_write().
>>
>> Set the block size to cache->bsize to resolve this issue.
> 
> Have you tested this with 9p, afs, cifs, ceph and/or nfs?  This may cause an
> issue there as it assumed that the cache file will be padded out to
> PAGE_SIZE (see cachefiles_adjust_size()).
> 
> David
> 
> 

In my opinion, cachefiles_add_cache() will pass the corresponding size
to cache->bsize. For scenarios such as nfs/cifs, the corresponding bsize
is PAGE_SIZE aligned, which is fine. For scenarios where cache->bsize is
specified for non-PAGE_SIZE alignment (such as erofs on demand mode),
imposing PAGE_SIZE here can be problematic. So modify cache->bsize to be
more generic.

Thanks,
Zizhi Wo
