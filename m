Return-Path: <linux-erofs+bounces-1677-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7ACF0980
	for <lists+linux-erofs@lfdr.de>; Sun, 04 Jan 2026 04:56:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dkNsd0mQzz2xP8;
	Sun, 04 Jan 2026 14:56:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767499013;
	cv=none; b=OG5KCHVVsp7qfFvIyCUv91g0itkiv8D2W9YJpR2JvwYxSdksYpLe3Tq+HfMZwBFMQI02yQzo40q8BC3DycR44dXx5l8cS99G+xZC5sbN9IZjDettvDZjNiVzlw57+Zl1U6Du/26flzDJJJ3KL00Bb9FP/+K8GhgmUo37xNJizVN0VjwZxvgQTc8UHiuqJUsCGwOq07Xnpn/TsZaLr2QTXW7qtHK85wsbx1LjCrwU3hL6cIgCJV4O27ElQHfhCjNLmfWMkFmRTSRoF/qWwcB7fzz5vr0SxZIDNx344wZsL2BTsfNy9xgZ+iyO6owEqmuRdAcNQ+nCCC1wsn6BXT9iuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767499013; c=relaxed/relaxed;
	bh=I1UBQbTJKdg44fsUKvwMvyyyIxcE0vPeGXNIza6CZMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtXh+c+1D/sKwXimTqrtNrf25P6WmyXsicRFg1ncURsY/PmkUhFvBBgUtIu9sXylyTanmRrV087Z9mgxmMlkCypa+AsGHg81qKNb18dtuu5zsq/vtM7sw9Mm07WWqv2vv/+4Sp0fVaHk9d7Bg7D+hO8nZhyrWhXW8gsJ+JH94RFM5h/UJEymyNYMIQCupDrRP1+7N37KEoMIRb4eVVEi3t0+WCleGfIASPK7Vi/baiSINMZ+CwVu8HSWXm2tPI1ihI81We3PfBOn/CFZHHPbnLBGUEoum24yVNblyWhtDyILJKx337o3r8eotRGOfCGqi7HAXRLlDE6uZB8xgiX1Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JZHJKe7/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JZHJKe7/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dkNsZ5Q25z2xJ6
	for <linux-erofs@lists.ozlabs.org>; Sun, 04 Jan 2026 14:56:48 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767499003; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I1UBQbTJKdg44fsUKvwMvyyyIxcE0vPeGXNIza6CZMs=;
	b=JZHJKe7/s5RQCOnjqmI6HvQhbjMCZh8e4dB6WRGHqAR/5QAqRiK0uW+3Iv+dvVBrv5+bOkgU0xq3kzwfc7qaJzaW7X0PyDtGkPgBJyZrhkZIBtxavnB5nq2t18tH1QdDozyGKtvNtp7NKxz5AC4xQeuUAhfQqcuJfoU9SCXHQcM=
Received: from 30.221.131.151(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwB0uN9_1767498999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 04 Jan 2026 11:56:40 +0800
Message-ID: <18246672-2c4f-415e-8667-2f826eb4fe19@linux.alibaba.com>
Date: Sun, 4 Jan 2026 11:56:39 +0800
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
Subject: Re: [PATCH] erofs: don't bother with s_stack_depth increasing for now
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Alexander Larsson <alexl@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
References: <20251231204225.2752893-1-hsiangkao@linux.alibaba.com>
 <CAOQ4uxjjxUHr3Tkxo9PkrBUPcYG1C309cYA9EEvk1-oVGcV_Og@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxjjxUHr3Tkxo9PkrBUPcYG1C309cYA9EEvk1-oVGcV_Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Amir,

On 2026/1/1 23:52, Amir Goldstein wrote:
> On Wed, Dec 31, 2025 at 9:42 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
>> stack overflow, but it breaks composefs mounts, which need erofs+ovl^2
>> sometimes (and such setups are already used in production for quite long
>> time) since `s_stack_depth` can be 3 (i.e., FILESYSTEM_MAX_STACK_DEPTH
>> needs to change from 2 to 3).
>>
>> After a long discussion on GitHub issues [1] about possible solutions,
>> it seems there is no need to support nesting file-backed mounts as one
>> conclusion (especially when increasing FILESYSTEM_MAX_STACK_DEPTH to 3).
>> So let's disallow this right now, since there is always a way to use
>> loopback devices as a fallback.
>>
>> Then, I started to wonder about an alternative EROFS quick fix to
>> address the composefs mounts directly for this cycle: since EROFS is the
>> only fs to support file-backed mounts and other stacked fses will just
>> bump up `FILESYSTEM_MAX_STACK_DEPTH`, just check that `s_stack_depth`
>> != 0 and the backing inode is not from EROFS instead.
>>
>> At least it works for all known file-backed mount use cases (composefs,
>> containerd, and Android APEX for some Android vendors), and the fix is
>> self-contained.
>>
>> Let's defer increasing FILESYSTEM_MAX_STACK_DEPTH for now.
>>
>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Alexander Larsson <alexl@redhat.com>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
> 
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> 
> But you forgot to include details of the stack usage analysis you ran
> with erofs+ovl^2 setup.
> 
> I am guessing people will want to see this information before relaxing
> s_stack_depth in this case.

Sorry I didn't check emails these days, I'm not sure if posting
detailed stack traces are useful, how about adding the following
words:

Note: There are some observations while evaluating the erofs + ovl^2
setup with an XFS backing fs:

  - Regular RW workloads traverse only one overlayfs layer regardless of
    the value of FILESYSTEM_MAX_STACK_DEPTH, because `upperdir=` cannot
    point to another overlayfs.  Therefore, for pure RW workloads, the
    typical stack is always just:
      overlayfs + upper fs + underlay storage

  - For read-only workloads and the copy-up read part (ovl_splice_read),
    the difference can lie in how many overlays are nested.
    The stack just looks like either:
      ovl + ovl [+ erofs] + backing fs + underlay storage
    or
      ovl [+ erofs] + ext4/xfs + underlay storage

  - The fs reclaim path should be entered only once, so the writeback
    path will not re-enter.

Sorry about my English, and I'm not sure if it's enough (e.g. FUSE
passthrough part).  I will look for your further inputs (and other
acks) before sending this patch upstream.

(Also btw, i'm not sure if it's possible to optimize read_iter and
  splice_read stack usage even further in overlayfs, e.g. just
  recursive handling real file/path directly in the top overlayfs
  since the permission check is already done when opening the file.)

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.

