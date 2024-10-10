Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D034998583
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 14:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1728561888;
	bh=hlIC0Y/+a4IZo0Zi0oEwnULIkhOhqPuLSspPNJvtfcU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hE+vpxsTBkPLJ/Gcrg05bW0cd9q/xhVt4uldzLMvntgwIZMBhjdJg0XYQqcoO0DsD
	 PCreDeyODEsBg0WVS8jVIMVlrEemALDAh+JYc6PEsoJGyelhBatPECe6FGIU9gEu9v
	 AistwcfZ0w6aK/JcyHaVrilbk9GI6AEuVlmAfzKFtyWbb8QupTKjHvNxPccx4P5k1A
	 +sfvVWEIBOU8nnDLJALr3QYo1Km1/MSukOeTOJnqx4TxEjsc9UerUiUbJenm6lPw43
	 Z2rpW3fJVeA97xVIL7oft0c92+H5y1qk7J/ACPMQNN56eDsAJkk94CdZh43I0qqWpB
	 jc6zGNjcseXiw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPT2m3jwDz3bjs
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 23:04:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728561887;
	cv=none; b=jO3QHssnaNCZnNzhlSZJKlDnMk/Mw6iA/S4OAagFDa4G5BXF1XEOLo6wMPTZcJeazVDLDlwEE2kFoDicGFSYq9dgVpoWYjpN1R70ECH6b9drg5ImGSEbjHOofqXFciFS1WCbNDkJlt0W1BGS+kJPMx5ypJX2rmx4wYKCZUtuV4qdTc1XsQoTy1/qXXkNgOdssauAT7DaW6pzPahyQI26Lea6xQAHxGdu8gKQVa+yXKZyFukuHeo7TDozaJKFvWY/sh4yKEAP62QyiS/jps4MrnQOraAflnrhDzq77dWYHvmC0pNp/CAsd/PZrHXngto51H4pz7X6WLvp0RvF7akHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728561887; c=relaxed/relaxed;
	bh=hlIC0Y/+a4IZo0Zi0oEwnULIkhOhqPuLSspPNJvtfcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MVfvrZQuitLqVr7HpwlkYqWeVgPcHbjevuoTMbxKRmrN1BeuPIFzDhdn536f5Kj/6XOfNZs9KdKIDhatAPMzk779sIKgmLCQ65gOTIHQHT0euZ8oIbRjdjEQPPF4VO/myWEsNfQB9Bgv4QJPIIGSriVkKSIy6Zater9d/rqrJWJ4ro3KQNdL0uyMq1txqh3Rip9P7PZ4vC454gBJHsrp9vY4l3NeWfqDeWNhepXt9QU4Nta+3KAgzSTBF/220Ni1Poz/KKUt945OfWwYytK+v5uXEOTyMQlfd8UVLAjms/5fjx3dO235fxiug3BY5lhhGXg56eoXGn29DKBC4UVoRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=szxga03-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPT2j3QpCz2yNs
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 23:04:41 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XPT1k6m81zCt9w;
	Thu, 10 Oct 2024 20:03:54 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id D06BF18010F;
	Thu, 10 Oct 2024 20:04:32 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 20:04:31 +0800
Message-ID: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com>
Date: Thu, 10 Oct 2024 20:04:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in
 object->file
To: David Howells <dhowells@redhat.com>
References: <20240821024301.1058918-8-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <303977.1728559565@warthog.procyon.org.uk>
In-Reply-To: <303977.1728559565@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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



在 2024/10/10 19:26, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> +	spin_lock(&object->lock);
>>   	if (object->file) {
>>   		fput(object->file);
>>   		object->file = NULL;
>>   	}
>> +	spin_unlock(&object->lock);
> 
> I would suggest stashing the file pointer in a local var and then doing the
> fput() outside of the locks.
> 
> David
> 
> 

If fput() is executed outside the lock, I am currently unsure how to
guarantee that file in __cachefiles_write() does not trigger null
pointer dereference...

Thanks,
Zizhi Wo
