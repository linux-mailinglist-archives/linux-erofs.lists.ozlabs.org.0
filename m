Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD400998555
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728560893;
	bh=vINald/ktHW/DDQ0ME+CGWhP3fZs7K1YyBzN6mRfcAk=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gOYPmlUuuGEGLUcUcda3qBcC0b7Yvu50fw52IBOKUfAorCCge4rD2yp1QwHREfILp
	 FvGpJ4YKeF7cCza79j5MiiDmzuNraKyHcwHloNa86nNFULKgzPDTmUeqhJrYTyhg7h
	 con0sD3+DTlQh2KSsoO5l9i7IT7nbOc3zRp7Cb5UwYOnnp0L/d1PXKln7/bqnPfnmI
	 rIfwMxlQ4D0UbtATZWQ4quVHAPmvO2P05U2mI7yfipNcgYeEmGNIjEdDaslvam8RBy
	 0vhUj9CosYMtPtN+FMRsLLyThjuMt25V3egYijSGLAyC23u/LjcAOP6Ed1JFt21ivk
	 NbYpvvHGKfiZA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPSgd2m7Vz3bjs
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:48:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728560891;
	cv=none; b=K9Ya6GRWXfpmx1qt5o5rXZnmxnJb8ts0YXgMWP6JQO+1MMhdDxL0fyD1S7PCZDY/sa+YtdYwOg9fpsoQYfwTWBxMpFHLpy0D3m1ejqxZz6JTnQur/S/2jMQzpkpuDm4qCHR0QnXEQAhr1GEVxURaw0+GgbwNgZfjs0OfuBkqLdCSCUgGegW0Hp98un/3lXdTgBTQHcJbuJJODSagzntAklhhzZNMWe1Ge4qUvAhYOfCoRp4yBGTwPMC3EXkkptZdA8CnYQ14b6xi69Sb9c9ChQmPQKkf/cwtEozlCVqaSMhc2ewR+q279aheEJU+68wbWmlBJ4Y+lYz0DNN9x5FRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728560891; c=relaxed/relaxed;
	bh=vINald/ktHW/DDQ0ME+CGWhP3fZs7K1YyBzN6mRfcAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PbuVsbwqn43RzniK5Tt+rqBrcekQ+yxPKPif9XKxqodLgrgfXXNCYrgD6ts49qDvU3n3DHKT3dY/P2Lj+tM0Gzao/VRwl5k7dD/cjD7mo7RT9r267EJIQo7IHNuWYmqpUrZhWFo+mFrTpXF8yl7xDYPrMCd3oyyupNDVbCFv4yNJltaYP6f4x6mP/MhLeBsB3V3JO2rJpNo/dl1WVfaiA89bmobDvnScu8sE7Bn6WRjGTrdiRXNva91D5Qqr9JU2nYF1uN+R97FoIFbAv8w1/Id9WikzU/yGTvI5haYbMROEWLu16zQLaMJCy2ftpqYjgumeJZFkJY55dPY30A29Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPSgZ1YW8z2yFJ
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:48:08 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPScn6jgHz10N2b;
	Thu, 10 Oct 2024 19:45:45 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id DFE8618010F;
	Thu, 10 Oct 2024 19:47:30 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:47:29 +0800
Message-ID: <df196eaa-e017-4f2e-a443-0431873a5d71@huawei.com>
Date: Thu, 10 Oct 2024 19:47:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] cachefiles: Modify inappropriate error return value
 in cachefiles_daemon_secctx()
To: David Howells <dhowells@redhat.com>
References: <20240821024301.1058918-7-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <304108.1728559896@warthog.procyon.org.uk>
In-Reply-To: <304108.1728559896@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



在 2024/10/10 19:31, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> In cachefiles_daemon_secctx(), if it is detected that secctx has been
>> written to the cache, the error code returned is -EINVAL, which is
>> inappropriate and does not distinguish the situation well.
> 
> I disagree: it is an invalid parameter, not an already extant file, and a
> message is logged for clarification.  I'd prefer to avoid filesystem errors as
> we are also doing filesystem operations.
> 
> David
> 
> 

Alright, what I originally intended was to differentiate the error codes
between cases where no arguments are specified and where cache->secctx
already exists.

Thanks,
Zizhi Wo
