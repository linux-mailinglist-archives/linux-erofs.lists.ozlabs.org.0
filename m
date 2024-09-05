Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718B96D2E0
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 11:13:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WztvW6skyz2ytm
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 19:13:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725527622;
	cv=none; b=Q3YrMxQOk5YAM8KJY48Nc0ajuINeLlzwXhiBIQ9NRXd8WJZL4nFfsAx7VBZ6vkCRawy8HScpvAoe359mCxS7rb80Qy1YD/S26l9AanQp+dw7OrySeOOB4Av99Qxg11cb1+szuvO8FpHFpIMGZLVmeU6GsFZEtcu0/erkoSfT8u7Nm4pLVyLwxeI8/YbEVv+pIGVzRda55gNBvubM0ILjZE6N6YvMd6/ClwQp/GgQv6mtsLfW+4PySQn8GIsgqgjkryQdxBHpYJwAbQ+riFxHC+6C6MmbjbO6IEo0zAl+9Gba2J8pfcxW82lUjPCcyKs/qc9+ckKfAfkb+OJi1h0+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725527622; c=relaxed/relaxed;
	bh=UwYdzizBlQz7pUl5vXmSdQZIKg/oWOvKB2rkQfbqDBg=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=cfaTguFNK3RacaZ6ZI1Rikke2ALyHKZz+tSbdeqeS20cq1z21QLWGAxoEcnvZ9Hx1HDfbh27CnVNhRhJFNEJgl9nq2VLbvgXJ3RKbt4GEcIx0VvLwRJCJjNNQB1nwYo4u44WqQXpJQuc63w3AsJlgT12nHLVDTZRBSxghudH0s/ml3U0CSiuFXjEJKIFl+HqBdoSRmhDA7RYtUj/prltFT4NddJ85ZsCEs7YX/gWpGVu3pzTj4rALNf4rPFQ6zHaRrJa7jqyCWLK0Cn/yVOVpkkukXc0K3S3DYbOjAYOnLk65b1Hxeb7gcwbTZnusafxzD5QX1mpcNYXkex5HUcVNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WS2lTUNB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WS2lTUNB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WztvT2wlMz2xwH
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 19:13:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725527616; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UwYdzizBlQz7pUl5vXmSdQZIKg/oWOvKB2rkQfbqDBg=;
	b=WS2lTUNB3ZGR2hUyTQuOPPXIJuVLgD8XHWwKpJe+NUIZvclgqSoiJO+lZ+P/EqLFwR51upEM2zvWRnY0+sSAPP51pTi0kFPE1aitAcppUtUz2MZiRghqhiuqf1uYo11bVNCniXUp9ZpGi6fW0YIJpsQiHMj+ekzxAmG0mBGxr1I=
Received: from 30.221.129.218(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WELClc._1725527613)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 17:13:34 +0800
Message-ID: <55267cdd-c832-45c9-bbe1-9c02473a2269@linux.alibaba.com>
Date: Thu, 5 Sep 2024 17:13:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
 <d095a86b-a1f4-4b31-8092-afa3ef1dfdb5@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d095a86b-a1f4-4b31-8092-afa3ef1dfdb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On 2024/9/5 17:01, Chao Yu wrote:
> On 2024/8/30 11:28, Gao Xiang wrote:

..

>> +
>> +static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
>> +{
>> +    struct iov_iter iter;
>> +    int ret;
>> +
>> +    if (!rq)
>> +        return;
>> +    rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << 9;
> 
> Trivial cleanup,
> 
> rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;

Will send a quick fix version.

> 
>> +    rq->iocb.ki_ioprio = get_current_ioprio();
>> +    rq->iocb.ki_complete = erofs_fileio_ki_complete;
>> +    rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
>> +                IOCB_DIRECT : 0;
>> +    iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
>> +              rq->bio.bi_iter.bi_size);
>> +    ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
>> +    if (ret != -EIOCBQUEUED)
>> +        erofs_fileio_ki_complete(&rq->iocb, ret);
> 
> Shouldn't we pass return value to caller?

I don't think it's needed.  Since ki_complete will handle error cases
for both (a)sync I/Os.

Thanks,
Gao Xiang

> 
> Thanks,
> 
