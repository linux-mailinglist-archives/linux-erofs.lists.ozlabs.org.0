Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A31738CE1
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 19:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1687367782;
	bh=3qgyDoinJYvl8oewWGepE9+Dsl5VdFOugT8tNhruwJQ=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y2Zk9ucetq9BRQyztDi1Yivqs7eINJPmYqpB+ghbicMK2DC1dTrtJ9dKuXOEyGMjL
	 DfCuEd9feNL1QFEgQ/oTVtBVvcFJN6RQdS2NCKQw9+KQWVEwEdftBlEDIyBZPH6gT3
	 FYr9bhRYhgpoimdFBuchKHvmVavurCPGy5OOyT8NudxbFf/jJMjD+GqeN6zBlvlkZq
	 OoEblFDoCGCP2GNOeY2uqeqnQqZ2sBkGiEEghEu6b3Y+TMmZlzeyqMfazYbUl4uexM
	 Hj0wMejPldlK0lT7lg0X8zgwfJ/wcd+iVPmZOxGXXndeR8wJx0Yqx6Dnye26HsGo+b
	 vndgXbbrHlNQQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmVXQ2JY0z2xsY
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jun 2023 03:16:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=TUknUXcC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmVXJ0bX6z2xsY
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jun 2023 03:16:14 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31110aea814so6414393f8f.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 10:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367768; x=1689959768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qgyDoinJYvl8oewWGepE9+Dsl5VdFOugT8tNhruwJQ=;
        b=T42zxmcWzRww5mWqrTXMiyynGSc5ygzCjRuMw6ACtviU9pqbYGMhs2e6BkVrRcqQ92
         zxxVN+EtOC90ylvKm3s+I5cYcTtHA4iWGR9qTKusoF7Bi1hWIfvb+L7MDx6fs06yFuMO
         zdRRoXNNjtEXrD/qCuiV0j96Qz3qTJ4bvywK6rBe+AoXMyreH4djniv/RJ3R2TyLz1ft
         olGcdZ/avBcTOHfzpN35plQ4bN4+jms82vngDyhbDryLNv6cwFDbQGj0mKgE217hftE0
         ddfivz5kSN77zqB14X9BZQXeM/xrC8EKibv/Jy4Asrk8Kps8gtN56NMKiynO1PHGop/z
         0F+g==
X-Gm-Message-State: AC+VfDw8aiEZQPclgnzvmD50O3IZfEPhbtp7THVEVTplAnalAF19fUgm
	jQkU7k0S5oCsttSk0e/MEfXolqm1zMwMf3rNPWtqnd7IAElElzw2unk=
X-Google-Smtp-Source: ACHHUZ6YdBzHZksP/uL3VkbL4Wpc+BNz9gGF5frWxWoFD/U+0vYBpj9tisxgWmHRjggedAcXkdDcO4dxuRCKORnAeUc=
X-Received: by 2002:adf:ce88:0:b0:311:2a2e:9c99 with SMTP id
 r8-20020adfce88000000b003112a2e9c99mr13040641wrn.45.1687367767909; Wed, 21
 Jun 2023 10:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=BE-SoekaY1oS1wn383DtHngO2BO1-gsUY-STHk9ciKA1OYA@mail.gmail.com>
 <4a8254eb-ac39-1e19-3d82-417d3a7b9f94@linux.alibaba.com> <CAB=BE-QV0PiKFpCOcdEUFxS4wJHsLCcsymAw+nP72Yr3b1WMng@mail.gmail.com>
 <9a8a07de-4364-3d06-4d48-2d51a74e1871@linux.alibaba.com> <CAB=BE-S2QpatqeiH=s+xJOV=n0J=W6CBgJY_UUtJ8JYEd7mReg@mail.gmail.com>
 <0195e8d3-a60a-d2ce-3311-a06f670d2ff6@linux.alibaba.com>
In-Reply-To: <0195e8d3-a60a-d2ce-3311-a06f670d2ff6@linux.alibaba.com>
Date: Wed, 21 Jun 2023 10:15:56 -0700
Message-ID: <CAB=BE-Qi+dWO_panrTwWWwCHWrO7c9AZEi0EMjyVp1TwSaf=Rw@mail.gmail.com>
Subject: Re: EROFS: Detecting atomic contexts
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Jun 20, 2023 at 11:23=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2023/6/21 14:18, Sandeep Dhavale wrote:
> > On Tue, Jun 20, 2023 at 5:38=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
>
> ...
>
> >>
> > I think this looks good. rcu_read_lock_any_held() can detect this.
>
> Okay, could you submit a formal patch with detailed background in the
> commit message (also why this original optimization is important --
> because we could reuse dm-verity workqueue to avoid scheduling
> another workqueue which is bad for app performance)?
>
Hi Gao,
Yes, I will send the formal patch. Can you please expand a bit more on what
your suggestions are regarding reusing dm-verity workqueue? Because AFAICT
we will only schedule to erofs workqueue or percpu kthread workers only
if it is atomic context, in other words, we cannot do the decompression
in the current context. Or maybe I misunderstood your comment.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang
