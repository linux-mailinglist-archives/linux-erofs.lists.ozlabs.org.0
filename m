Return-Path: <linux-erofs+bounces-135-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8DFA75E42
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 05:43:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQxn14VVzz2yFP;
	Mon, 31 Mar 2025 14:43:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743392613;
	cv=none; b=jYM99C44hIVhEb/Z1TPfmY0u1opDiigdOqdjL9q82WbQ4y6WEp38HRl92j3wGTByP0jK/8Xf//lSmC9GQM8PcnhhEIc4XuVoCDqs42aLbOomMBW2Bf49n44ijRH4D7ffyTTC3d/cW8Sk/NylWdfWDDuxoOlEpXa7E5jtzWFLvFHiGAtU5r8YFjdbpeyklLxyrv9Ca+yPKGXrpmN2h/Rl5PCpLv8NV2r/OntYYmzH9OdU76bYffUcrBSpF0r0mpr/Ks+UuUhfhDsTRg3C6YVYhEWphNAwhNO/OwaPWHEaAVEEc4j5tccv7RddEejXn+apeYs0NiTgrStNQijELSoobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743392613; c=relaxed/relaxed;
	bh=VIgce8rYt4aTtV7PAuyGh5tPMio2I0JJh7iujL/QKs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsB9N7rUrZtHG6ToQ6V9oFJSMReT5DsKcWeBBqR4yktRsZu/tkFb4evUp3e9J5CtnYBMz16sQT9JzktJE/zkJz5RVA5HeB/3n48ibYz7Wb33bw0P3w8T4QgdoW2y2/HNLIahMBGYc0Lw0hvTd6GfOm+7+TRMBrInscNHizXcPG8gEbbAh+BsO9wVGi4eSY8tZEnPXXI3lPLABNii8Q6iNTEKsxDV/LoddxdD4CiRzMmXwdpSq0WvT8xsVruz0K/yeUcQGOhXu4VJRCmaW1QOP3Kg3WdJ/IHJgwOdkpd8o5mWJGqR1cBopd0XCMZ/262fsAfajPT/Jnzm1mM2p8E4KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=aui/0UyP; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=aui/0UyP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQxmz6VVzz2yDH
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 14:43:31 +1100 (AEDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso6546850a12.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Mar 2025 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743392608; x=1743997408; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIgce8rYt4aTtV7PAuyGh5tPMio2I0JJh7iujL/QKs0=;
        b=aui/0UyPBw2fMEWzNxCxc8Pe2GLM3cXVdjjvqeYDHbjRSScG9gBamrRUilEDLyu78V
         xvn35SbimHjfjyIxm9cAgedvGKtQvaY7CngRVV9Khs1kn87kjeWyg8301gJpF1vT9hc7
         6CPKG4AcNg5FQoUrBmOKOcwo2UsEWOFFCAF9CQlpqrNkpr1QoswsqqfINYtsCJW3uSXk
         qVljQXTYZDn+MU8JOol0QsBiXIE/PrjKEN6QUNadG/s1+qej2Edwg/H1f/TB7IVzSlzh
         yiHbdHMob7gDPZ+EftHzyia4jCO0JdYED6AEevM3hR5Ni9alxjJ7jbG2H9f7A4oG3Tks
         Z1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743392608; x=1743997408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIgce8rYt4aTtV7PAuyGh5tPMio2I0JJh7iujL/QKs0=;
        b=dVkHrCMt6N9NB1VW9XSeZ2iINaZV2wyrbcLmokpWJd0oEQy8KN2g17ssXYK06uffKj
         8AIOohZ1HK4ltJ1Xw+0rcDit+aRTl8ZbzxUtKbRzwQXyNFAtSF/E/GQjTJi12FBTLxnQ
         CG2k6yOlg2qXVSNcB6iDyavI90DC0Ai9oaJv2qR5m+sfwAmc8XUqrhC2t6uxlfdv0ZRw
         KIJnL785ajqwQSJqDN+H6UteP2Cdigski1CbRtC4RKuHtQ/G+gMkgr9D1hrOLxfD223m
         ODvGCW8fMg+HVA6jO8yIXWErnUGD2wvz7xGeknF3mwDVxjqyPNHEa8xzWRjoKfMyamcV
         aOvg==
X-Forwarded-Encrypted: i=1; AJvYcCXzuhaqE3/kdMjNz/Fmfo/SC0X02urXUveHtP6oAjEhdEDYTSwT4DLFwu4xP73w6lEViYMKWQH8rpf4VA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcQm2xLBKDUMBdM872xRQZEDdd/y6ukfH739io8oGNwmnMpJLA
	ENi6JvJS2n6vQNCp7eFcVMzdo9SXxuRkvtSGC1cR6miGpk53vInsKZBa/uXlZA4+t3boUY66Pto
	/212QcnM52pxbNj3iiPgpxT6WnfK9ZH/CJEvg
X-Gm-Gg: ASbGncug2f4Ab5qcHIdej7j0AeYpHVzn1zd8GnJerxvdeaHWKVJvw+DvXjnRmZcuz3I
	NmcQE9hpN5DT7k+cu1JMp4jkAjrTZEmrnViiRUi+USY2qtr+LSECKO0gQirPboBhi5MlSf3tja2
	ePX1JSXNM9KFqx9uHPNh0MDw==
X-Google-Smtp-Source: AGHT+IESsld6VWFECGofP9BceQ8i/cdTOJdsfLxIy+vnI7DUGPMG0XrgDjfQez9ovs+KkU9eIO4UhtoV2gr60umX7eA=
X-Received: by 2002:a17:907:97c9:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ac7389e1864mr648782866b.13.1743392607844; Sun, 30 Mar 2025
 20:43:27 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250331022011.645533-1-dhavale@google.com> <20250331022011.645533-2-dhavale@google.com>
 <45548d9e-4cfa-476d-9eaa-b338f994478c@linux.alibaba.com> <CAB=BE-S6Brg0e277mdY-d3ZwrGeUe3idz37_FJVaTesAFTGfnQ@mail.gmail.com>
 <330276be-f9cb-4263-85f5-20fe2e10cf72@linux.alibaba.com>
In-Reply-To: <330276be-f9cb-4263-85f5-20fe2e10cf72@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Sun, 30 Mar 2025 20:43:16 -0700
X-Gm-Features: AQ5f1Jqr6eSN6rYZq4yyqWPR_jex1f2WbOqmzkzHp3p9RSlj0nqOhUgFQiq1T-g
Message-ID: <CAB=BE-T_W_EFndyKN-61b9eup52YZw0M_OuTL=sOsZH3QFkrRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

>
> Is there a real use case in Android like this?  It
> would be really useful to write down something in the
> commit message.
>
No, not that I am aware of.
I was just trying to cover all the possibilities.
> >
> > Can you please expand a little bit more on your concern
> >> it could cause many unnecessary init/uninit cycles.
> > Did you mean on the cases where only one erofs fs
> > is mounted at time? Just trying to see if there is a better
> > way to address your concern.
>
> My concern is that it could slow down the mount time (on
> the single mount/unmount) if there are too many CPUs
> (especially on the server side.. 96 CPUs or more...)
>
Yeah, that would be slower.
> Or I guess if kworker CPU hotplug is not used at all
> for Android if "suspend and resume" latency is really
> important, could we just add a mode to always initialize
> pcpu kworkers for all possible CPUs.
>
In Android CPU hotplug is used and has been working for
couple of years without issues for devices. This was brought up
to me for the devices which are not using erofs yet.

I will take your suggestion and work on V2.

Thanks for the feedback!

Regards,
Sandeep.

