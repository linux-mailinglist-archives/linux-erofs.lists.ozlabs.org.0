Return-Path: <linux-erofs+bounces-1446-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1893EC908B3
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Nov 2025 02:58:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dHbzm5wGdz2yG5;
	Fri, 28 Nov 2025 12:58:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764295092;
	cv=none; b=KQ6MVrkntrXBi9bG70H1PbhMYn3mgsnJW6PqCFUuC/aqlHidKrtXx5H7MLYW5bmsuAa/NDav6AgHrcWHJPSCMpqmL7CN/EcxA1eVQ4OrsERGu6M8NJJ3q2wF+zSRkBVv3v7Ef+HPBOBAgv47PEIOGzmZnhmzINU6ov2zKXlY6DH+EqWRS516gqdnRb4g4P/Ec3hi4l6ZrhxbkulHtp44Lq9wkqH+0cTR9A0Jih1quW7mojTvYzy1uFuqF8GCwA478Xf79PjD+8S1oaQjEtclnGypdQhXkT1tTW6liouvf40gDaTFYhm2DLfxJCV7KIPUzieuUSHwcBf9EZDY2Dx1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764295092; c=relaxed/relaxed;
	bh=c2ieEv/xIsEt38uURYmMANNeIDhTzIYb5HlDSR+msmM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YDjWo8eYEN8AyJu2J4cpNBvfHqujMZe7DBzZWC4tfqxCbY41NyiXlA59zjN1GN92CQrsutc4HZ20bvAI14JfPxbT6CAaWfXnYZqR9SSndkX/f36TcWL7J74fjcxJhDxhmEekzVG1uBdoq6FaY96ALa0417ZR0D9kFdUVGMSspd0TCD7pCPuNPfsYBNBPjdZJUkZHXwbTP6iTNjqJe/KksshWX4vHCoDUC9EQrfxlo2pFyFPS3BRMtTEL/A5uT+aBnOa/hrOx3reUOU45iwOeyaDs2rWnyPSgAgtMbQHgxFQ/IhykVtNaNxT1FrpYWqoVSxj8ZwmhKe6pO0OQGs48jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bLqTnVx0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bLqTnVx0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dHbzh55FDz2yFy
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Nov 2025 12:58:06 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764295072; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=c2ieEv/xIsEt38uURYmMANNeIDhTzIYb5HlDSR+msmM=;
	b=bLqTnVx0hfl7lLzi3P9uZ1lXGX8cj19EBZAPvygHXL9qG0thUHfMZWfv2OHE/dqznh6lcWo4qd/z6Mi97GbPEpEkEjSF7QGmOttTtpMjFgcy8yl+kQk+kzej5Gnb8BcTIKIKmz//j7bX0ZGMivzgCfGLisoYrFSonhIINbWurSA=
Received: from 30.221.130.183(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtZP.Oh_1764295070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Nov 2025 09:57:51 +0800
Message-ID: <c6c3774b-16b5-404b-8876-56588d22b61b@linux.alibaba.com>
Date: Fri, 28 Nov 2025 09:57:50 +0800
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
Subject: Re: [PATCH v2] erofs: get rid of raw bi_end_io() usage
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Stephen Zhang <starzhangzsd@gmail.com>
References: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
 <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
 <aSjzua4jp_zZ1g1o@fedora>
 <c0c827d8-569a-49ef-a6ac-a758744533a4@linux.alibaba.com>
In-Reply-To: <c0c827d8-569a-49ef-a6ac-a758744533a4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/11/28 09:40, Gao Xiang wrote:
> 
> 
> On 2025/11/28 08:58, Ming Lei wrote:
>> On Thu, Nov 27, 2025 at 04:07:56PM +0800, Gao Xiang wrote:
>>> These BIOs are actually harmless in practice, as they are all pseudo
>>> BIOs and do not use advanced features like chaining.  Using the BIO
>>> interface is a more friendly and unified approach for both bdev and
>>> and file-backed I/Os.
>>>
>>> Let's use bio_endio() instead.
>>>
>>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>> ---
>>> v2:
>>>   - call bio_endio() unconditionally in erofs_fileio_ki_complete().
>>
>> bio_endio() can cover bio not submitted yet, so:

( btw, nevertheless, it's not submitted, just with or without
   a given bio callback. )

I believe that is ok anyway.

>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> Thank you and Christoph for review!
> 
> Thanks,
> Gao Xiang


