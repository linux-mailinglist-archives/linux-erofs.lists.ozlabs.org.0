Return-Path: <linux-erofs+bounces-1974-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E06D39BF3
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 02:30:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvXvT2nhKz2xS5;
	Mon, 19 Jan 2026 12:30:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768786213;
	cv=none; b=c+zCNMt6CguIxF2oScBhbwplyQEeCt8PPGoEM9y0b4d0wgcmT7yGUtpaJmhgARPhj4dg0Ql5zhOBO5+tX7jE2c6mOhkpEfbI5mQ9i2IgirlcQ1pLK+FYNp4uJMzrtGRxzu51EeOlFpi/v6C8kphVsfUAVTHalO3ftRhZ3m+kM9SIrQXMQ7GdpEmwkw8UQFviy1OKtV52ROydGXn0n5tZCBUQ/6t03SNT4eJ62osWdETcQIusCkBxGSqtcHe7v33zcEEybn/SRxAg5UhH6qOids6e6T/V+LPn2/Jwo8HiiEDpIH8vAn1eEgpEZoFnCti2D4GnKrwcSMUlrLxQUBg+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768786213; c=relaxed/relaxed;
	bh=DX+cVov4fFysjYhRJQyIa6FlEjht2c3WZDD1AZ+Vh30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D5zrKTeJNbbmuQtcAV+Hsx8JnJlYvM96OdcKDcE67uHGidfX8Uv+vqlxC+t0mZijpzYFkB7rPcy3Mt7qCdccxMw5eGetUNWfb1YnyN0S7oQmvBdDCtFyp/44HwqYcMWPAQV8V/biFgd9dACfaTxtrupkxDQ/f/MunoQ3anujnZLU46ImfaTMgVlAJLc+2ZDNksSnxAf3TYT1EYHIMmmfGD6iyN6AXpEFkgV+qS0q9ma4JctlHzUHv5hq8xX9rUchF9091bHx8+8d4vTphmlpggDL8aOiBk+iQepnuUHFTgKSKAap1SdBvEf1eXOmvxTdPmLSNSJr1pwWPIquOsNhmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xaZj3dYa; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=xaZj3dYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvXvS49Z2z2xRm
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 12:30:12 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DX+cVov4fFysjYhRJQyIa6FlEjht2c3WZDD1AZ+Vh30=;
	b=xaZj3dYaUAmJgLAtqYmWF5bWWZGR7qv4prEgcwhNd8LY36Rfmtr9Zarj/uEGHJRxwaWh7uItO
	JAbVtmAxxOgDpzKDwPIh9CDS8ZwzQZqvNQ6DU+N0DbLwSrvB4kSN+N82+FS+p8XLqZvcV6YqZw7
	MtuoGgpmnQCgwyn8hZ9eiWw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dvXqT5f5tz1cySS;
	Mon, 19 Jan 2026 09:26:45 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id A6E2E40539;
	Mon, 19 Jan 2026 09:30:07 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 09:30:07 +0800
Message-ID: <1444f838-b755-42ad-84a5-bcc76b1a76c2@huawei.com>
Date: Mon, 19 Jan 2026 09:30:06 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 9/9] erofs: implement .fadvise for page cache share
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
CC: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-10-lihongbo22@huawei.com>
 <20260116154654.GD21174@lst.de>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260116154654.GD21174@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/16 23:46, Christoph Hellwig wrote:
> On Fri, Jan 16, 2026 at 09:55:50AM +0000, Hongbo Li wrote:
>> +static int erofs_ishare_fadvise(struct file *file, loff_t offset,
>> +				      loff_t len, int advice)
>> +{
>> +	return vfs_fadvise((struct file *)file->private_data,
>> +			   offset, len, advice);
> 
> No need to cast a void pointer.
> 
Thanks, will remove in next.

Thanks,
Hongbo

