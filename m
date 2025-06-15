Return-Path: <linux-erofs+bounces-409-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C766ADA117
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Jun 2025 07:50:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bKj025wqxz30Sx;
	Sun, 15 Jun 2025 15:50:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749966610;
	cv=none; b=HsmlujgH8dnTkG0grS+dMhwaOXkJNjbTIfJ1+RIkB/p/hWEJKYlPiJhWp/HcTMFcE4DL9XAuK++K6Jp7gakhX7FZ1eKHS45ODK2G9tDjRvN+qsMA0TomEuRt0LLali4TmKukR09O3A0+nlQEd5ve1P65ElXHHP/5tMIniVvFlybQMhfdiPaN3TN01hfF8BBSRQP0mVUTDho+EA2Dr4yASOW2XEqDE79sVv7BH8W6sj4p0zekhsEV5ktOFMK/IQYKEb95H8Q4G+aoFogBC8/o83SmVmKjtZPrHnOR7Y3WquGzpbfLDnL0m5BxR+F9IYBDxei5Q8s+Da67wI00edjkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749966610; c=relaxed/relaxed;
	bh=w+0CrxDqnkuzZTYUwubgUhqWxAs2khRXstAaVSFraRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQLnnf3znRxsUQUu61nYxFAlLRxah8xZaVWvovFgghIxC2HIpwaPZVTp9mbCMGt4Pu735upuShApK9NWz06r1ckr1F+HH3f7NhbTaglWVIJYiRVJsbSHE+yu9L+P9qubF3kwVOB6j5bLRsB3DODxMxLqElnQtDfv8vd9oef5IV62ZYA/bbusBRRE/cTN9o25Dv+kPx0z0stQPezutw9HX8KMu9PkjoyS7wojBNVP2l3ZVtaavx+EciEPPZ7I8u0g3AvU8Z2Zfr3W+fCwKZzbFq7FbCOgNjOqQkx/GUhpGv+boLIM49yXiGurwDFLUmMccV1mVBsfs4HXFIl9dCJWdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wAx9HNGB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wAx9HNGB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bKj0064mTz30RK
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jun 2025 15:50:06 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749966601; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=w+0CrxDqnkuzZTYUwubgUhqWxAs2khRXstAaVSFraRI=;
	b=wAx9HNGBft1go6/5wyos6yuJUJTJcDCuVtX5jqEglbCNQzfvQndKgc3JEdZwJlR1hKFHohIPBmnej32NQw6YvRQU6g4GX0mhTItd9EHkvBPdd3qoQTZjKNR3mQfjC9hQ7FxKgbepc0kiVmUBU8YsRLMt1/ir8Nqu7wgwx7lCpyM=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wdp0hqa_1749966590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 15 Jun 2025 13:49:58 +0800
Message-ID: <54e69067-1696-453a-b8a3-3a6967e03b24@linux.alibaba.com>
Date: Sun, 15 Jun 2025 13:49:49 +0800
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
Subject: Re: [PATCH] erofs: confirm big pcluster before setting extents
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Cc: brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <684d44da.050a0220.be214.02b2.GAE@google.com>
 <tencent_15B5C44A7766B77466C6B36CE367297EA305@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_15B5C44A7766B77466C6B36CE367297EA305@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Edward,

On 2025/6/15 13:05, Edward Adam Davis wrote:
> In this case, advise contains Z_EROFS_ADVISE_EXTENTS,
> Z_EROFS_ADVISE_BIG_PCLUSTER_1, Z_EROFS_ADVISE_BIG_PCLUSTER_2 at the same
> time, and following 1 and 2 are met, WARN_ON_ONCE(iter->iomap.offset >
> iter->pos) in iomap_iter_done() is triggered.
> 
> 1. When Z_EROFS_ADVISE_EXTENTS exists, z_erofs_fill_inode_lazy() is exited
>     after z_extents is set, which skips the check of big pcluster;
> 2. When the condition "lstart < lend" is met in z_erofs_map_blocks_ext(),
>     m_la is updated, and m_la is used to update iomap->offset in
>     z_erofs_iomap_begin_report();
> 
> Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
> Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
> Tested-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Z_EROFS_ADVISE_BIG_PCLUSTER_1 and Z_EROFS_ADVISE_BIG_PCLUSTER_2 are
valid only for !Z_EROFS_ADVISE_EXTENTS, so I don't think this change
is a proper solution.

 From the commit message above, I don't get the root cause either.
Anyway, I will seek time to look into this issue later.

Thanks,
Gao Xiang

