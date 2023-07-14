Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186475431B
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jul 2023 21:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689362150;
	bh=cWpYs8CNOdGMvN7PUCKK7yk/Bn/GzPi3qlDukGM0svY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cJLhB0qRcpuamdWt50+YerdSbtqbbrBy0PLpPTkf1pCRSLSkUhYE9t7qBad5bq8Hs
	 JEvqZ8R+AX3F3KZrCta4X0Smsi9Z9NL0oDh4owbSN3xt8qaSua290GajbnDSsEqOvY
	 ycKdlkJ32K8hHO3JEJCmf9N6HeHp+VL6ZJI2j8eOA9mTZ4v8age2j1pmPlwWueSRCT
	 /S/xjDH+E7i65k4O5+YSCii7zAJF7TuJtbF7LeR96aDfr/lSxNyZ1K+ZxNmB1KCCwh
	 0HJfRBeRCli+rra38vepa8L0ALDBykWAB273+/gkn0Akz7mMXpME5d8eP2avQHOCSk
	 O/6xpd6sWWGqg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R2h5f01nsz3c51
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jul 2023 05:15:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20221208 header.b=u6PqySub;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R2h5W4TZtz3btl
	for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jul 2023 05:15:42 +1000 (AEST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3163eb69487so1918173f8f.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 14 Jul 2023 12:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689362135; x=1691954135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWpYs8CNOdGMvN7PUCKK7yk/Bn/GzPi3qlDukGM0svY=;
        b=P9HdOuCtXaCgJTJ81grYH4P8lOBKGY5IZMrL9ye41/EvS7O806ToK7NKJedP01iFLf
         XdihnKhNgsaMHLSulfr9cpnQDQcV/UOdbd4TbTytfRo7okA5+el0IacH7NhcKrx8ZzJu
         HpfpbaTirI+u9NiSg0i9XuPj0Igen1JISClV/y7hiF6aHpWFZgRi3v8W0RUB9v+SYJw2
         vg3DxfasS/gQ32AqMXSK9gO/q0uzZ5M1oEAKE74T6VM7CgjBILbGgn2fxquQjoyV/8Y4
         +F69N0Z8y7JiXuTmId0ZFFohSS990sIvYILtt3haOke57/Dn8GPLPXYMOHbA80EVbnau
         Sr+Q==
X-Gm-Message-State: ABy/qLa5IoN3wDLQGA1lD9X0xXRjjqhiQ3g0ArI/xzZ5qETrd+slzjaE
	VTjH45fCN+WKYz/z1qwrZXQAaDqewaxRlrDUwXzkmA==
X-Google-Smtp-Source: APBJJlHX6dLj7c4mGTpQQffA8nPlc153rMil3AEv5RNyi1HYhhgbFITU/Tv7HZL6ycDAMJ2p0B6XqAyqBusI0MosC4I=
X-Received: by 2002:adf:e8d0:0:b0:313:e2e3:d431 with SMTP id
 k16-20020adfe8d0000000b00313e2e3d431mr3161529wrn.12.1689362135219; Fri, 14
 Jul 2023 12:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop> <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com> <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop> <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
 <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
In-Reply-To: <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
Date: Fri, 14 Jul 2023 12:15:23 -0700
Message-ID: <CAB=BE-TC0s++t_5H6NjVVcpNvvvubtUpJhRxPsqq2p3ZgaFo9A@mail.gmail.com>
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
Cc: kernel-team@android.com, Alan Huang <mmpgouride@gmail.com>, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Frederic Weisbecker <frederic@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Joel Fernandes <joel@joelfernandes.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng <boqun.feng@gmail.com>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

>
> Sandeep, thoughts?
>
I prefer to modify erofs check and contain the fix there as erofs
cares about it and it's
least invasive. For contexts where erofs cannot tell for sure, it will
always schedule kworker
(like CONFIG_PREEMPT_COUNT=n).

I will also do measurements to see if erofs should continue to check
for context and
what are the benefits.

Thanks,
Sandeep.
>                                                         Thanx, Paul
>
