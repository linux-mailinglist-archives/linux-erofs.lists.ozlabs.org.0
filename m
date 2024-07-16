Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F893215F
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 09:42:18 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F9HU1kPm;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WNWHX0X32z3cYk
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2024 17:42:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F9HU1kPm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=huangzhaoyang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WNWHR5Ywwz30St
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 17:42:10 +1000 (AEST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so70883791fa.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2024 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721115722; x=1721720522; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6oQBxZ5QuGyuJ0jlNZgghoqLrDpW/cpGfahJKhccgs=;
        b=F9HU1kPm+4fwgu6rgDFK+NFC/zf1nb1cDUZvW72owxbiqC3cFnq60Oe0p8snQDQPha
         Ff89DdHqObJQaZYfoRIJhqkgRN034vJRpC2aeAmciZd3MeqBDzed+ureujbv7g3444Hp
         KyzXiXDC1JNff+rQluEem5k4yVnAAX9VQVqZZSQnUL3C5UXlcjk+/7M8HtE2xc3aaZQG
         k724CWuYHWSj987dU7GW7hplK/WK/pjE1EtKbPX6ar4gmLsxhFOKoSlVdWR7naGVcV++
         tw+SxCAeoDVeTcYKsKk3wq9YXZ4Bhp8caSY4A9waLEM0oJn4uhwMCq0QmGl4YqXzG2ZE
         Klqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721115722; x=1721720522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6oQBxZ5QuGyuJ0jlNZgghoqLrDpW/cpGfahJKhccgs=;
        b=CIJvUb7qkok1Af6VHr3uY+S03w3yRAEdY/5gAmeJm4VQcN1DA4F/Yi2gLTZ62LKQ8g
         UV6Pwi6vMu3/ukg/of+zPHoE4yBeFcli6ULgaSazkI8REyovUlIDqqcMExVyR/5Yif0T
         g95k8XWXFHNjYi54uAkxt55PgfiiDi1tOVPXaRocbRMTyg9Aak5FxYZuUEAG4FLlWklX
         lLBmRKQBWu3e8Me3S1bEChAgXu1fvMPgrzL2YU6aVJMZbWoWLMt8jOnaxdIypK+GrokD
         eCxqP/hQGn0xjyyzpOr99wPeWKn2EGrsla+Hf9E6rEqGLsb2/JrIOVesPD215VQAWVOG
         Glfg==
X-Forwarded-Encrypted: i=1; AJvYcCXhUqUb9ZEwjzQg6lok0d7VtgxwPQr0IEDhsb+2lCt2egxx4zKMRdrKpcUr5NDaRQIP3gp22hq5iKa9ZIFmBZIm3Zb7IKAbWVxOauUz
X-Gm-Message-State: AOJu0YzLbMHk6Wm2daw8J5vSOb1+LWGxdHMN+GMt7vTny1ZsxnYIwFUO
	ddtfFHVScl3ve3eBzMV5qjqENMNvVC9IuCwjDtKVIaiGD0BBmYjkVkFqxKbU2e8nElYaYEo8nts
	EpVjTuqx9fv/SkgKyHsiaEdKDKak=
X-Google-Smtp-Source: AGHT+IE6nggtsGSzuBIDEwpdazMgwsW5mU8I3nuB/Vie0tWToLMI9S7n3vSfyJAKL7D9tQijzO8ujf3ueQ7uutRA8GQ=
X-Received: by 2002:a05:6512:2354:b0:52e:764b:b20d with SMTP id
 2adb3069b0e04-52edf01bee2mr815553e87.28.1721115721853; Tue, 16 Jul 2024
 00:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240716054414.2446134-1-zhaoyang.huang@unisoc.com>
 <d3629955-71e5-442f-ad19-e2a4e1e9b04c@linux.alibaba.com> <CAGWkznEpn0NNTiYL-VYohcmboQ-kTDssiGZyi84BXf5i8+KA-Q@mail.gmail.com>
 <a41d38bb-756a-4773-8d87-b43b0c5ed9a9@linux.alibaba.com> <CAGWkznH4h=B1iUHps6r6DKhx2xt-Pn3-Pd1_fFjabeun6rmO_Q@mail.gmail.com>
 <dedea322-c2c5-4e1b-b5c6-0889a78c19fa@linux.alibaba.com> <8754d1f7-1180-4a7a-a2c5-40aa9147fad6@linux.alibaba.com>
In-Reply-To: <8754d1f7-1180-4a7a-a2c5-40aa9147fad6@linux.alibaba.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 16 Jul 2024 15:41:50 +0800
Message-ID: <CAGWkznEUAJGzAD5iJ-wrwW=N4tYb1SGQtDZY7hwzwrum5QxGTQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix schedule while atomic caused by gfp of erofs_allocpage
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-kernel@vger.kernel.org, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, steve.kang@unisoc.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jul 16, 2024 at 2:50=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2024/7/16 14:46, Gao Xiang wrote:
> >
> >
> > On 2024/7/16 14:43, Zhaoyang Huang wrote:
> >> On Tue, Jul 16, 2024 at 2:20=E2=80=AFPM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>>
> >>>
> >>>
> >
> > ...
> >
> >>>>>
> >>>>> I don't see why it's an atomic context,
> >>>>> so this patch is incorrect.
> >>>> Sorry, I should provide more details. page_cache_ra_unbounded() will
> >>>> call filemap_invalidate_lock_shared(mapping) to ensure the integrity
> >>>> of page cache during readahead, which will disable preempt.
> >>>
> >>> Why a rwsem sleepable lock disable preemption?
> >> emm, that's the original design of down_read()
> >
> > No.
> >
> >>
> >>> context should be always non-atomic context, which is applied
> >>> to all kernel filesystems.
> >>   AFAICT, filemap_fault/read have added the folios of readahead to pag=
e
> >> cache which means the aops->readahead basically just need to map the
> >> block to this folios and then launch the bio. The erofs is a little
> >> bit different to others as it has to alloc_pages for decompression
> >> when doing this.
> >
> > Interesting.  The whole .readahead is sleepable, including
> > submit block I/Os to storage.
>
> Also, please don't imagine your stack trace if it's a non-upstream
> kernel.
ok, it should be caused by a vendor hook function of the android
system. sorry for interrupting by my stupid.
>
> >
> > Nacked-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >
> > Thanks,
> > Gao Xiang
