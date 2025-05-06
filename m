Return-Path: <linux-erofs+bounces-283-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983ABAAD14F
	for <lists+linux-erofs@lfdr.de>; Wed,  7 May 2025 01:03:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZsYpL2q4mz2xQD;
	Wed,  7 May 2025 09:03:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1746572586;
	cv=none; b=NkA6TfXrCvOYnc/umMRxri8CBuiviIGMhw8JwvmiwWdxtgUE9P+9osgjpkyu568pJottINAd9aaP1uotw46C7A5OLSyLFRDbbtTIKUY+cVGRq7eqgWkdOKn4EuTi5c5QQtmXaO5nrjU4K9jSqqr5ueprLKA0A+U0K9h/PXbm2E2OI/5OuLYMrQ+8dFsHdyAN1jmMtYKkGURajJta4MBk3RzBu0XuEXuPj2tvzl4ORnutjb1TBNmnHh+OrL/uTAek1n7QdS+0jWh2+1EfPJx0KLfr/M8Z+g0DzxpCvLgHRXb3RIndM42OuJ7w/CEhr2t3WgjXmmsnJEwYZSDr1rxNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1746572586; c=relaxed/relaxed;
	bh=sPF1HHimx0iwlaJma09DLD4bF+ZsfFO0Z26KdaLYRwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MktniB9e80D8wu2iX2qW92+NO8XmNxitqAcC+gP487yvHacoKVo96stPRrJPMVJHrusKpCKx7fxufRK4OrbTw5MyCQJLHe3n0OAH26dB/sKrgq2EpIu5coBM5dHNN7Z/HSETle54w6mcaBWAd9fyYJLvJmFc1If1wLi2NWYXFIFsUrlMHslgR5tOmGZ35wOES7yCo85HS3UqejBD/9Go4XFkfNrjA/GOhCiDpcG7+g6BFl1VRXXPrkeFsVuyNulMcJgzBcVJv0/7FJa2A+cl8z+nQZdN9a60uvVo2U3DE4OYqJsPBcCl6hQQSl4uSVn6xNgrliD1AmmZcsutDEZDaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=PbNdA/Gm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=PbNdA/Gm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZsYpK1WSgz2xQ5
	for <linux-erofs@lists.ozlabs.org>; Wed,  7 May 2025 09:03:04 +1000 (AEST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-acbb85ce788so199535166b.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 06 May 2025 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746572579; x=1747177379; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPF1HHimx0iwlaJma09DLD4bF+ZsfFO0Z26KdaLYRwk=;
        b=PbNdA/Gm4PuGt5CR7jhWFsJEOrV7YsIiI/KSg580MiVzExxpn69Xlrq5KuVa3vdAnT
         l9hby3m1R9MFayxfCUxvJ6ujRAFPs59mY85BtZfxMR/7r9pauFo5Twqvbck5GTW8D7wb
         dyd9m+cpBimK1fYyr5viS4wJ2Bem2JcY40jXLWuT0SYXBY0gmAXYu1ioTBpUpxKz5Iey
         JZumgJ9jpFnUbYodMppEdnp5Q4th95BGvT8NBVsoVROIbPSaLRRpsntTI03FUolrbuFy
         t0Dr0SJ+x1891ESi951XmsWAgkdwWqlGS63Nr+81gH3+fF15Iv0eX+qUOGLDkUp/cVhz
         ld9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572579; x=1747177379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPF1HHimx0iwlaJma09DLD4bF+ZsfFO0Z26KdaLYRwk=;
        b=Uvwi7t5041FXeNdVR+GsRaQWMx7iQAMupTx6z8smoib8Deup7lMVZTuSVFbDqUlvRx
         SUkk2CFNdcfH39PUmFrmmoU4+SAUl2KaYQ9pGY3Hda4AGJQ+DDzCOd2JMPN0vEYUWKwr
         eptJFYKEL8IGeSGl4hpao1HJ1dJMU8YKCnnH09zwcmKLOrOWkv04FcpXyH9ywnumlBM/
         OKRp1hlpDtV3KeG1SmaEp/ISx1sWq/f0aoaZPdEW5Zj0zUAP0yfGPq8Iuu1nag9Q1GWI
         8v0F9lcrJZgEWT/HRH3WkJHUUUUE9aNhKqdNWgMQKumylz1ZXr7Qdi6OxQBwWyAsgonD
         Ubpw==
X-Gm-Message-State: AOJu0YyJpsbYcUVcGPyhVVW+wJF/sbxaxHkqYXpPeFMxm0fQ38hZYYy6
	88RFKAUlhXFZiFklGCQzEaKoCwT0uzbnoFJ1mqyhgQ7LE+1/11izWIkSal73arOh+FonstPFqGY
	eeYTk4KlRPT6pvBxPwAfupNnUeShLSwS7GURxDFYazs1KMF+fNs0lci4=
X-Gm-Gg: ASbGncsZENmoPCPfkZn7ayBLBfEp7yYSCrxTw5/Cwja2zd5Sd/YNS0PAoL2DjuqMlEJ
	6FOLUuUtTq1x8zXvldkxqPXUhO/JrWeyGFCuD4oPcTtlQQ6h+zfQvHHvq9wzaBWuJMR1KpOlMOW
	ReQp6dtavolg91+jYoSg83z1ZEscy5V9Yk4g1IzbXvSwIZXGjtjt50725vce8SweQ=
X-Google-Smtp-Source: AGHT+IGlfnGNn8hDgkOu8o/NgFGH1pqyHUQqxoxq5+kiAqPyoRN9Wb6Hw8UoV84uLHR6ovC7vq8IKwPsB/ICeiIrMVY=
X-Received: by 2002:a17:907:868c:b0:abf:4ca9:55ff with SMTP id
 a640c23a62f3a-ad1e8c4bf54mr115077466b.32.1746572579146; Tue, 06 May 2025
 16:02:59 -0700 (PDT)
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
References: <20250501183003.1125531-1-dhavale@google.com> <8de6a220-45a3-4885-890f-0538522e620c@linux.alibaba.com>
In-Reply-To: <8de6a220-45a3-4885-890f-0538522e620c@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 6 May 2025 16:02:47 -0700
X-Gm-Features: ATxdqUEDJEVgJ1EMBd53IsNa00CsNwfMNSebym8JlkwrHb3JPWhns_xk2akXl5s
Message-ID: <CAB=BE-S6S4m-uk9r=eQdM1foi+3HpZrEh0WYD5S9Q-aaP19G9g@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Gao,
> >   #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
> >   static struct kthread_worker __rcu **z_erofs_pcpu_workers;
> > +static atomic_t erofs_percpu_workers_initialized = ATOMIC_INIT(0);
> > +static int erofs_cpu_hotplug_init(void);
> > +static void erofs_cpu_hotplug_destroy(void);
>
> We could move downwards to avoid those forward declarations;
>
Sure, I ended up moving the CONFIG_HOTPLUG_CPU block inside
CONFIG_EROFS_FS_PCPU_KTHREAD. That gets rid of forward declaration and
also much readable.
> >
> >   static void erofs_destroy_percpu_workers(void)
> >   {
> > @@ -336,9 +339,45 @@ static int erofs_init_percpu_workers(void)
> >       }
> >       return 0;
> >   }
> > +
> > +static int z_erofs_init_pcpu_workers(void)
>
> How about passing in `struct super_block *` here?
> Since print messages are introduced, it's much better to
> know which instance caused the error/info.
>
Sounds good. Log message now looks like this

[    8.724634] erofs (device loop0): initialized per-cpu workers successfully.
[    8.726133] erofs (device loop0): mounted with root inode @ nid 40.

Thanks for the review.
v6 addressing this is available at:
https://lore.kernel.org/linux-erofs/20250506225743.308517-1-dhavale@google.com/

Thanks,
Sandeep.

> > +{
> > +     int err;
> > +
> > +     if (atomic_xchg(&erofs_percpu_workers_initialized, 1))
> > +             return 0;
> > +
> > +     err = erofs_init_percpu_workers();
> > +     if (err) {
> > +             erofs_err(NULL, "per-cpu workers: failed to allocate.");
> > +             goto err_init_percpu_workers;
> > +     }
> > +
> > +     err = erofs_cpu_hotplug_init();
> > +     if (err < 0) {
> > +             erofs_err(NULL, "per-cpu workers: failed CPU hotplug init.");
> > +             goto err_cpuhp_init;
> > +     }
> > +     erofs_info(NULL, "initialized per-cpu workers successfully.");
>
>
> Otherwise it looks good to me know.
>
> Thanks,
> Gao Xiang

