Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7463B752A7D
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 20:52:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689274320;
	bh=CRTSQeUdEcnOajeYoZyJyVr14RVak3GBVUbXP0XQdD8=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ZxhRSrUHq62A8FFgLJJw7E+oEuBEGGOlz24UPB3yH1iMLZkFZKdqJoW9e2BoULbZ8
	 o9/fx6W5j82sA0ilZuA55d2TxZ23vAa5KM39qnuMT+5WhqZOAcUG2qLB9zmfPJJoZE
	 QoeoAYvBv+M+KwomHVBZt3aT8DO8QDEf4EkYhJING/cTcLCdPMeMSy/3Pzl842/qcA
	 KTpXnS1cfAbdHRVkfC199Yi0speYrcunU7Lm8wtMnx93U9ofFNddRv71Ozn2s0qVDx
	 yc8GbANrH7U5Zcbkqrr6PUiQrszx7rpQeZz7TRkwwz/tuAQjohZbDhI1mXJJ/DLDM9
	 7Ei6HcLr6xLZA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R23cc5dSvz3c5W
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 04:52:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=k7idrVD3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R23cT5QrQz3c4t
	for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 04:51:52 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so10217085e9.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 11:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274306; x=1691866306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRTSQeUdEcnOajeYoZyJyVr14RVak3GBVUbXP0XQdD8=;
        b=Gofsxuum7DEKIcWxcqi7eMyTuDArqBlVYI1XrjZ8WIYRaeg2UWXFVzYGAcfBfrme/h
         Jjd5wWSKT9ruu0KnZCThcl/uX0rUxlpbFHC494C5+vD+0Oes2HycdjwtYSZOvlFpXR9V
         4kHiU3vV3YyBN6SvVXW4jYuz2pYu92k6A0AMfrBqI1lBzLHoctaPTIRs9MWrehti4sfO
         DcBCETkQ+AlZW3khL7Shn42d4aWL1uoP+6/5k+SLtlLsBxobgomGr/muWSsmesdLRyDz
         dxmbwJS1kW3593oBxmK3zNuba1pucqodLx9T1V9hT6WL56mYmvEyZRGaiwH4kpXbAVN2
         hZ+Q==
X-Gm-Message-State: ABy/qLZIHzPidF293VvDppdD7mrzKib1ykPY7am9RMFQ9H97AB4lU+uK
	K0su1wJL+ZymwZI5QkRC67rV35+2lC1amCkCtmKREQ==
X-Google-Smtp-Source: APBJJlGvHzvAe/oR+TTlkHcVqp0fo8lpXt8SG+ObjVCv6Vz7ojUSg+bE3wo3qfu/bC0DdnxZh+XcOdlxLsXIEcAD5hA=
X-Received: by 2002:a7b:c5c5:0:b0:3fa:99d6:47a4 with SMTP id
 n5-20020a7bc5c5000000b003fa99d647a4mr2316810wmk.22.1689274305706; Thu, 13 Jul
 2023 11:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <161f1615-3d85-cf47-d2d5-695adf1ca7d4@linux.alibaba.com>
 <0d9e7b4d-6477-47a6-b3d2-2c9d9b64903d@paulmck-laptop> <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop> <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
 <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop>
In-Reply-To: <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop>
Date: Thu, 13 Jul 2023 11:51:34 -0700
Message-ID: <CAB=BE-QNFhOD=xe09hiZOLmDN7XQxnaxyMz1X=4EeU7SFKaRKA@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To: paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
Cc: kernel-team@android.com, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> Thank you for the background.
>
> > Paul, Joel,
> > Shall we fix the rcu_read_lock_*held() regardless of how erofs
> > improves the check?
>
> Help me out here.  Exactly what is broken with rcu_read_lock_*held(),
> keeping in mind their intended use for lockdep-based debugging?
>
Hi Paul,
With !CONFIG_DEBUG_ALLOC_LOCK
rcu_read_lock_held() -> Always returns 1.
rcu_read_lock_any_held()-> returns !preemptible() so may return 0.

Now current usages for rcu_read_lock_*held() are under RCU_LOCKDEP_WARN()
which becomes noOP with !CONFIG_DEBUG_ALLOC_LOCK
(due to debug_lockdep_rcu_enabled()) so this inconsistency is not causing
any problems right now. So my question was about your opinion for fixing this
for semantics if it's worth correcting.

Also it would have been better IMO if there was a reliable API
for rcu_read_lock_*held() than erofs trying to figure it out at a higher level.

> I have no official opinion myself, but there are quite a few people
...

Regarding erofs trying to detect this, I understand few people can
have different
opinions. Not scheduling a thread while being in a thread context itself
is reasonable in my opinion which also has shown performance gains.

Thanks,
Sandeep.



>                                                         Thanx, Paul
>
> > Thanks,
> > Sandeep.
> >
> > [1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
