Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A23994A7B
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 14:33:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNFn804Dyz3bbT
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 23:33:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728390826;
	cv=none; b=DwyUiWDL+lPjnWIyOkyOPy7m1Q/Su7VK5N5Et7jAu/MvjE/e5vft+D9pkI6BBAAfIKTNK+im3s3wMe5tEVSywVoHCwgIxb0NU6nEGdbZML6J1uRCV1v94aEUpFzC/WBVSKFN4Qc13+ksuoPJGH+EnyaOl0qT1bH9iNpH4jmtWA14wL7OURmv9/SY4tbjuqql32wEQb/W21RPshu8+yRkJZo3pJ1gq0r2mdVxj8VGTEd92HlVxrKff3djxy6q4FvPw5pfDdglQSnFPOuM6dozxhIFmzUB0cIZq/27/gc9QvTS0OaMDHfoBTLNbt6YfqTSK89eyAx48/N7CWlvuZpohw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728390826; c=relaxed/relaxed;
	bh=+7CVaWdRPLDuhY1NRAeUcBP6A0gvCm63US2OSGofAi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1fx5neU1A6ajbqdrFhdVWhP+xYCGrppwYCgvPDH123VyHul3LPQ7vsS7MZUfA3yma1Y0WnYGAjEtta4ya/M4rK7ir04DkCSPCwQT2kgrZIuvzSSOw9ws+BxnVBMQUrEdJWJmxgK8/cKSaOu2Yqk0nl9joM4x1gLtpykqzbyTKCTyK/E38LunyH+ldF+InyncyS9ruzy2t5MI2sYr3uAKN0WGgCSOA8dkX7yjwaqWanjOQ97HtAOCudu4JaRp0+JkqL001ZYuu36O2/5jxPNjlCJvlqRRRDkiCzLJ1XKwT9ipDRGrVVYsX8SFhiJ9BPuoyRFDVfqFgQRHO3eiIYzmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NDjm+kkk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NDjm+kkk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNFmz6xtwz2yst
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 23:33:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728390811; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+7CVaWdRPLDuhY1NRAeUcBP6A0gvCm63US2OSGofAi8=;
	b=NDjm+kkkJZ8sZzLeIEOMG0IMGWdvHl5Im38jIoU119BSgmPbDcBGuFACR5tvxrYy73RNvXvypoWhp4j3yvLj8kBsOPqUWeZE0pPlwaqu6i1JteIBarJtmOv0QNmnofisX555QDY9semcG7TpSY+jBiy48HB/Er1YiBYppKALTic=
Received: from 172.20.10.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGfRGHx_1728390808)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 20:33:29 +0800
Message-ID: <ca887ba4-baa6-4d7d-8433-1467f449e1e1@linux.alibaba.com>
Date: Tue, 8 Oct 2024 20:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
To: Christoph Hellwig <hch@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
 <ZwUcT0qUp2DKOCS3@infradead.org>
 <34cbdb0b-28f4-4408-83b1-198f55427b5c@linux.alibaba.com>
 <ZwUkJEtwIpUA4qMz@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwUkJEtwIpUA4qMz@infradead.org>
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/8 20:23, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 08:10:45PM +0800, Gao Xiang wrote:
>> But the error message out of get_tree_bdev() is inflexible and
>> IMHO it's too coupled to `fc->source`.
>>
>>> Otherwise just passing a quiet flag of some form feels like a much
>>> saner interface.
>>
>> I'm fine with this way, but that will be a treewide change, I
>> will send out a version with a flag later.
> 
> I'd probably just add a get_tree_bdev_flags and pass 0 flags from
> get_tree_bdev.

how about
int get_tree_bdev_flags(struct fs_context *fc,
		int (*fill_super)(struct super_block *,
				  struct fs_context *), bool quiet)

for now? it can be turned into `int flags` if other needs
are shown later (and I don't need to define an enum.)

Does it look good to you? if okay, I will follow this way.

Thanks,
Gao Xiang

