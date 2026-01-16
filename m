Return-Path: <linux-erofs+bounces-1965-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A218D33767
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Jan 2026 17:21:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dt4qD6vxzz2xm3;
	Sat, 17 Jan 2026 03:21:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768580488;
	cv=none; b=M0lw49o45iOt7KH9RPYEWKZeLWdC4r2MbTM9K7kQtb14IcdabtRy7REiO7yz/uP6RAwun/TeqKe5m4BNlFZqdq/N+LlKNpsIXpnD8iyovb6d4Z9eygP2As/0kVyTcUlX7s4onBrpylWKib3bPAMSdy7WH6fd01JR2RxUvFNjwkBRSePOyH9wnBr+q3MJffhQBhFGsGCJQwuoQWRNvnvwNGqw3Ov/JbkOnuGZNaSOkmIdbVv43s5wUEoaqwRX/KEOQWsmEU4FzSFMWZyiEg6inEVMd0A6E1eE6chSVN7aw5xA+NHj835H0SsRa0jisViduXpohnmJnMHat3dZr99tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768580488; c=relaxed/relaxed;
	bh=ZpOJQ6ooa0mcia/fcatFm9psF59FZgaxBeQaFIs6dr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0PHdf+RXbvQo78qQVMVKuiRkPY+LshRQQXEKjOmNk/8SxeF/jvbkaM2WylBU8gPfZvdgz6zNZqppFasE1cWbXid72mQ3C0PpQQa/2CoKiui0IPW+lPIyrqbWYVsuDzYsobrQPB36/GjsQZImdkBoBIqXf74V/U9oM0Sd4SISccPXdUoN4Ultl9Yh7c30tzqe+rrd5dTg4iF8SdmJIfYv+Daz5DHUqLvMqV2G9oRn066Z79pCfFcTx+qf76ZWjkPNdSwX6/xEOw33DaZZzCHaInsU4tKSwh3bfv8RD7UrvZrrcGGu3tt6eUJkOMQdE/PCWc91ry3fzDgDi/iecqm5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qEKSsN8n; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qEKSsN8n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dt4qB5ZsXz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 Jan 2026 03:21:24 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768580480; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZpOJQ6ooa0mcia/fcatFm9psF59FZgaxBeQaFIs6dr4=;
	b=qEKSsN8nDp1yADGak5kO6yyg9yDWuURu98vb7fK+Ovy6++XNqjw+5njgkqpaWl2OMRwNuS3mLvocL13tibTWcreovoh9YxPdywbZeCYw6NY3+/1IwezO4V8mxHFWqjKN8qvH9Td9FLV2aOKdcTNK1ckm8CGMP2Ubke09g89JZXY=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxAgkQR_1768580476 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 00:21:17 +0800
Message-ID: <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
Date: Sat, 17 Jan 2026 00:21:16 +0800
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
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116154623.GC21174@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christoph,

On 2026/1/16 23:46, Christoph Hellwig wrote:
> I don't really understand the fingerprint idea.  Files with the
> same content will point to the same physical disk blocks, so that
> should be a much better indicator than a finger print?  Also how does

Page cache sharing should apply to different EROFS
filesystem images on the same machine too, so the
physical disk block number idea cannot be applied
to this.

> the fingerprint guarantee uniqueness?  Is it a cryptographically
> secure hash?  In here it just seems like an opaque blob.

Yes, typically it can be a secure hash like sha256,
but it really depends on the users how to use it.

This feature is enabled _only_ when a dedicated mount
option is used, and should be enabled by the priviledged
mounters, and it's up to the priviledged mounters to
guarantee the fingerprint is correct (usually guaranteed
by signatures by image builders since images will be
signed).

Also different signatures also can be isolated by domain
ids, so that different domain ids cannot be shared.

> 
>> +static inline int erofs_inode_set_aops(struct inode *inode,
>> +				       struct inode *realinode, bool no_fscache)
> 
> Factoring this out first would be a nice little prep patch.
> Also it would probably be much cleaner using IS_ENABLED.
> 
>> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
>> +{
>> +	struct inode *sharedinode = EROFS_I(inode)->sharedinode;
> 
> Ok, it looks like this allocates a separate backing file and inode.

Yes.

Thanks,
Gao Xiang

