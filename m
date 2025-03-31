Return-Path: <linux-erofs+bounces-133-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB5EA75E19
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 05:14:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQx7h5pjlz2yFP;
	Mon, 31 Mar 2025 14:14:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743390880;
	cv=none; b=Pq7iHclj0e+pcUNqXlgmZTnEKP4xKkZ2GIOpEOL3UtMetHGxrH7O8UXqiKkssOEYJjcCFogTefW8jGk8Ob3c5r4BV0shVJRyQMr3a2buHjlgrf6Am5f5sz0W3xOvyuG7NHF71hpWg9EASGx9sNWZrj/90vZauX6kQ2AnuWOt5oqUxWMhvbZ3titAh0HbZ9xEs+KRzc/cJBerZmzQcZFjwK6a+GPblIOqwrLHha2V1r7x5YWsmBPoVaoCjHhvCyME0f/Wo4M4Wd66yg39R4IKzHj+CNoUrXteOzz1btKtOZT+jEpYVN+mKbGXbOx2x9DIh8KCp0uFuyr+JrDa8jUcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743390880; c=relaxed/relaxed;
	bh=VMO1QGK0kZtFj1xGxtjV8T/YmC7nhGXlI25kqEbZCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGXi3Q3l98D68GITDr4E43CA+IfV0086KuwnhwoHzDvht9ZjSQ4E/+OoSUrjmmgfPvtQxE8QAjFhZGuS0TSTPXIWk/ifoglXQHa+LQ3XnO7ZBvEJV7IYJ5ueJRz5DvsYOgczbgxCjj0MCYJ6qhOyZXCh1HJ4AgWz55U5amiawxL8Qt1RLnabBwcjGTHWo9X5mWbKWXw1MfXRi5DqqTfcT/6jl0Q05VoPeF6AUywuVDciNBJDlQ9Vig2MM/SpeMHY1ZuW+KTcHgFVpGWLucPcIbDLGLyH75Kvacxm4miwbwoNgg8xMGSGaf0jQEugLCsNE0MQqTHVRtRBkeVZcqTNXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=FfkWXnne; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=FfkWXnne;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQx7g10vmz2xpn
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 14:14:38 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-abbb12bea54so807679066b.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 30 Mar 2025 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743390874; x=1743995674; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VMO1QGK0kZtFj1xGxtjV8T/YmC7nhGXlI25kqEbZCC0=;
        b=FfkWXnne8YXG+cZaC531VtmIVYWp5w7tjwcKQ+r95Zint/zfwSAYwGFVeNp2VqC233
         g0ONi/IRVyAcHT6GdiIQu9D7aauuvRJ4i7eApWB8upun4g/4LaPDls1CEuFa+mav+wbJ
         DLAnTZXAh1BcUpDoLQcq53ZyDOUWtshLQQOUG4tN6jUd3CrOWOZLSa5WMwwR7NIFyM4+
         c1d+BKabeX56yKXlZlra+KqxExHk5G/3KWGtRrKH0Sf60op/3Td+vFEbVxLpm4nH8grW
         qhzgRYwJh7scUvMEwsHuyEeKBPmkiaEuxxKnrYyLU8RsxxusHtb06D7S/XnJ2sj/dXvq
         3kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743390874; x=1743995674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMO1QGK0kZtFj1xGxtjV8T/YmC7nhGXlI25kqEbZCC0=;
        b=DPd7Mnr88+jpjce/dptdpCsSpeUg/HSTJpOCBIz7jDKa7OleqvE2pXfycZu1AKpfO5
         HMQhJ6lo3Z4R7OCqUo/41e0SxC/MFF1J+jnoxha3+jT7chhWPoboBS+Bae82cmvEkZ8h
         AFXY+EgrlWZWir+GshKIFgiHN2EEgcDmX00PKFdJ2UpR+0IAXyaLxduQXkOdYEY9IK6d
         H60OCMcERSeLlPkSO9WnXBaygDmsUOjq0JVoJzBScJxCeRMWFcRsgIFee9+mYIoN/hh6
         89JCUc4Pi+ve1GNi20YN5GHTjaFT2Jr8zXhXtnMk0EEPIRKPRagxPY7crBKh+aHsz+nf
         RrHg==
X-Forwarded-Encrypted: i=1; AJvYcCXcmjbsnT2QzZ+MUS5NXOujWkRgnhgseFK8DVdmCu2dcaGHkQ19OtcGrptp4KI7qiUCLORNXZZExULJPA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy84JH4FQQU1P1QU61ND9ToANNf9Ipoh6k3MHJcEDMMayaRbmiA
	/brPTJeSkzwYxbsTYt59at5CLaAio+38+fvSD/ogAPXjL/DPQyEaiP4nctSx96F4xEEkKqvMK9h
	YViCmDuCca3t+w1TjXAC8jeyxazNFgDJUFdg/
X-Gm-Gg: ASbGncvXTR6GTrYrATanpPS+VOFMF3iAdA7TYFU1+T/l7RjevGmc+Mk2kR5j4QTtYGh
	DxSVIVX1jBfnS4epl16uyj3iv60SEtpiw1uGnoWaTzFLcybZGcBXRfpBaSWPpebA803IonjObSf
	gYKGe8HjQLjoa/u1blVWSogQ==
X-Google-Smtp-Source: AGHT+IEcjCiEdaVFhcaOLq6mYf51/rkQa4ioe/o8LrmJDJwCNxC3Y52svPuxkHyAq3hpvK2OLIxqMGFAGsTRXjA4wrs=
X-Received: by 2002:a17:906:5657:b0:ac7:391a:e159 with SMTP id
 a640c23a62f3a-ac7391ae30emr508952466b.60.1743390874365; Sun, 30 Mar 2025
 20:14:34 -0700 (PDT)
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
 <45548d9e-4cfa-476d-9eaa-b338f994478c@linux.alibaba.com>
In-Reply-To: <45548d9e-4cfa-476d-9eaa-b338f994478c@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Sun, 30 Mar 2025 20:14:21 -0700
X-Gm-Features: AQ5f1JroCNq4Yy5sw2hbu7GoipaHkBCgmdnmK2oAA_WFw0A02wR6icNSL4dPg3U
Message-ID: <CAB=BE-S6Brg0e277mdY-d3ZwrGeUe3idz37_FJVaTesAFTGfnQ@mail.gmail.com>
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

Hi Gao,
> Do we really need to destroy workers on the last mount?
> it could cause many unnecessary init/uninit cycles.
>
> Or your requirement is just to defer per-CPU workers to
> the first mount?
>
> If your case is the latter, I guess you could just call
> erofs_init_percpu_workers() in z_erofs_init_super().
>
> > +{
> > +     if (atomic_dec_and_test(&erofs_mount_count))
>
> So in that case, we won't need erofs_mount_count anymore,
> you could just add a pcpu_worker_initialized atomic bool
> to control that.
>
Android devices go through suspend and resume cycles aggressively.

And currently long running traces showed that erofs_workers being
created and destroyed without active erofs mount.
Your suggestion is good and could work for devices which do not use
erofs at all. But if erofs is used once (and unmounted later),
we will not destroy the percpu workers.

Can you please expand a little bit more on your concern
> it could cause many unnecessary init/uninit cycles.
Did you mean on the cases where only one erofs fs
is mounted at time? Just trying to see if there is a better
way to address your concern.

Thanks,
Sandeep.

