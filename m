Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F69C8340
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 07:39:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xpr8p1xvXz2ytN
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 17:39:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731566345;
	cv=none; b=UQCAGA48xRYTfN15BgeqSisxWYxMlAASq9oWt64bSgHKU2MAHlxeO8+W++c8MnhCHZ/4RDXs7SzQKe7M2+PdVAxrKASvyrGuXL1GtqjWJblP/aebxxwVF+yyX0RLeNQ3nhjW79p0uihr5paEsiwqzNDJSmUTuQSWrjiAb7U53hjFXi3oiRSF3ZJ41KacjeSzuq/CO42xghkaCe1uToZKrEMQugY/247XbjiiQjpEks1QMyWWCVe3wOAkh5qvwS2BMNtLMns874iPsQw/B2l+/62RR21zu1mcb2BeyXAXf9+m3+6+3K2AFuB+HKulCH+EG0VXAs7lO7ErSTGbTYT6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731566345; c=relaxed/relaxed;
	bh=9Gunj5vQo63mYOinHnhZqgyjOHsdlSs0pB4xnbgZGmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lg7s7TRGGsUFDdshVtk2bGRBaHAc9cv2vBv+fPce/5tSuVH6T5R8AAa54RFU4phdPMZ0Qj0Q6n65/WSuz0Ncu4V+V3IJ2aMhqUgpTDCQANulGgSwhLkmaoeseccy5hHvl76GiQFzv/3YPPCtCZG2BuOUc+Iv81GEC6JFWdl0Tfkhtsh8YBkdoAThfK8oFF2Uha8ljvmB8q0WKgyjxw9qVScaZr6ONV4xRPfuUj3laC4DuCDo9Rr5lpd5oH7T5Dt9W4wZSQmwu5bIwekqkqsVjoS/kB4DR7TcH7O3dZm8rk8LaOXOiDQNMI97N4puXv+UIkDM5N3d3CkHrEvNSkpjNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V8sdrgH8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=V8sdrgH8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xpr8g0pqCz2yMv
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 17:38:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731566333; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9Gunj5vQo63mYOinHnhZqgyjOHsdlSs0pB4xnbgZGmc=;
	b=V8sdrgH8moX7klM7oiWIrJHm3cn1EyAU/PvvYICI+XQriSUAipExYKe437ecFpxskM0fiTA1N8w772R4LmpUIlyqBU4zn6MmyA4WxfVjdEovrsdgUlz0EjH2F9lgzb/JmvBaG4zngoGb/EOa7UeaxNfJUNQmpA8ztutQfpwm9K4=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNT9Tf_1731566331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 14:38:52 +0800
Message-ID: <0a82d4fc-3b2c-4b04-a0ee-539bf6896c6f@linux.alibaba.com>
Date: Thu, 14 Nov 2024 14:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix file-backed mounts over FUSE
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
 <20241114060434.GL3387508@ZenIV>
 <61c24337-798d-4a2e-82bf-996e86d0c0fb@linux.alibaba.com>
 <20241114063422.GM3387508@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114063422.GM3387508@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/11/14 14:34, Al Viro wrote:
> On Thu, Nov 14, 2024 at 02:23:27PM +0800, Gao Xiang wrote:
> 
>>> 3) AFAICS, (buf->kmap_type == EROFS_KMAP) == (buf->base != NULL).  What's
>>> the point of having that as a separate field?
>>
>> Once buf->kmap_type has EROFS_KMAP and EROFS_KMAP_ATOMIC, but it
>> seems that it can be cleaned up now.
>>
>> I will clean up later but it's a seperate story.
>>
>>>
>>> 4) Why bother with union?  Just have buf->file serve as your buf->use_fp
>>> and be done with that...
>>
>> I'd like to leave `struct erofs_buf` as small as possible since
>> it's on stack.
> 
> enum + bool eats at least as much as a pointer, and if it's on stack...
> an extra word is really noise - it's not as if you had a plenty of
> those in the current call chain at any given point.

Yeah, enum can be avoided now, I will clean up this enum
as a seperate effort.

Thanks,
Gao Xiang

