Return-Path: <linux-erofs+bounces-2936-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPPBJqEXwGmlDgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2936-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 17:24:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6702E9FCD
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 17:24:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ff1p56bNQz2ySb;
	Mon, 23 Mar 2026 03:23:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::833" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774196637;
	cv=pass; b=Qx0wIFNoCELkzVw10KY561UjseglfV39CKJhFUpfJaZx+JlVD5o+h55H1MuKyHVfwGL9GXmI6w7EZXROIsBxLD0WDwS/RcNvzUlkVxoZVlB9vtTYW7gl0Wzf342Pj5LQ9HN29CtJmPe6sZLjiYse2b1Xh8wogMThWAhvxYmxZTWim1TXUc+WT7C0fZEW0VR0aiKwoQVCzbKIGiN6EoLNkBmW9Kag/EH7JdVkHIHhbwb/Tl6gaI/bCrcGwnukKHbsqtDQPTuUgejO/GADwxveuqByV6AdfSEqoV/zh1Dfn8m9WZec/mrK8CKkwrfm8fLOtU3IxqlAqEnuQxXKjbeP3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774196637; c=relaxed/relaxed;
	bh=Zbdn4vPN5cgK7FPa6pqazAFG/fMOYydVq2qVkP841Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYmLO2j9xCUUApabPj9dVfj4jj7cEyUh6/mJ12yV98K7sjNlx1GgTH1DumfOTDBeRcKpqyN4AunpZc9J8PovrzXm+ejWdNqAsh94HLpd8HUONd9Pd9M2MPb3zOf7UXcCwlNjilDT8wEQJ2Iefi4N27JNj1TlLuIlf15pIJWbCzK2CrT/1UU7YkOysrM/WwYx4IvdKlcYr28hrTnPH/DNRDn6by9yjbLzI8b/766EUBw6gEiZJRW/HgUwhJO9Lyt6hY+06lKChi3p1xeS0sqyzE648A4IiMKFg4ZAXShRVx3UDzy9GxTlLTa1va3F3hU0k7Roj/AARyEj+l+RtRPciw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gl3U/DTA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gl3U/DTA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ff1p45gM0z2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 03:23:55 +1100 (AEDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-5093ca242f1so4091341cf.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 09:23:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774196633; cv=none;
        d=google.com; s=arc-20240605;
        b=L5A7BHI0SA0GMT7Jmk7A2/4qqY1TK0swCRdiFTSVMwO4zonbUM9/mKpiQtrRc6VWRs
         0bmjqXtPG25PY0ielPCNsBSYVjoW9/PHkMBSiLsGrKnLcWWjSFdzA5Cw+hyCkludMDf6
         4WI9ZkPBXvS8bshFn0nCc3myHEisC4mbwiqNEvnbPzyPghsx/GGjo+BqvYVzwF46udmq
         tpZANBQGvxkR3CTnnjmofutzoCR5LY3CVKl3JNt9/lygzkByleHZYusAQY9/S9vx6PNo
         0J6b0RKs+TtqpQyneYONQJ0UPMxjyqn5ufnG7wzTk94Mk6ObdpJRs0UKTUxXrcbHRmxr
         g1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zbdn4vPN5cgK7FPa6pqazAFG/fMOYydVq2qVkP841Do=;
        fh=1uMYvvbY1J66B2sOWCOWtaf9rn2ud2yw/eKj4SM7GHQ=;
        b=GEds38VM4n49LcIu4Es/gBPdFPUUihB61rxhJYIMYgNx3je1k4I7Zw34AvbQOZOFgQ
         AqOOA0tKDLEw9uLdVUpB9pLEP2ok4+Si3hjYv/Um46oiXFAuF6eA0D8xbR98UuILVELO
         BCxY5+TnBosKH6172amLRT1Eqi7HMWgLfGtQDNjB/5AkLnWuUinZcvFvjWs6tEw5UkG4
         IsTK89MaE2b5E6T1kaVeT7BBW4GWjobLjPMylG+GcNIoXu7UoXl+To5VNcJouCsYJCBh
         BUZ8Dbtz1v/dfOyzFLGNrfmxg8QkdqWbo/FzjYkGKE8qijwqYWrObSfxKHEi+KzhNqbA
         xy/g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774196633; x=1774801433; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbdn4vPN5cgK7FPa6pqazAFG/fMOYydVq2qVkP841Do=;
        b=gl3U/DTArKpbv0yrGHpRlDeiEv2Tx4X+YXfHDxdxdvXvQ0d5xbPFIca1xNcd1tVKkx
         UKhGaSRvEBXoF80bCW6RB9o0yJxQetRph0jIRDe1HKY+GA7VLTcTsqMVpDJJiH5Q4XLd
         pJdhOrKgYD9lvB980AWvule7nxGhSoJN5rqxeBwGYn9wLp/KuAtR5PDAQ94CdtbA4lXh
         4o/l/XJObmsWFYDW3zzGOEw52Go8YlrwRmUPfbQdyYurkwWp6yJqCuuslqa+v4ITMLpQ
         n0fbQrFWYgtTXbv/w0AFd58I9zF+MZQK7IWTvW49ZV3dUQbbUSx8bpzTux4G7JTbjEqp
         Xd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774196633; x=1774801433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zbdn4vPN5cgK7FPa6pqazAFG/fMOYydVq2qVkP841Do=;
        b=XgPAZjQW5+4FdernSuoUjvlwqaTethd4JdzioBsJaCML8VmfygcQucSD5ybYAh3yhU
         x/P6JlOBl05NwcLewu3EW7uVXZRqGMZFQ1PwaPhgLboSQbHEXu3IgL1ZeEEBAVMyVxs8
         VYnlVPnBmYtx+szOxtqPPxMvJ7JHoWRQAgxa8ZHPgxUcA88A4sPf9aW8VL4j4Is9Kw02
         7Mt9WHtgIwUW5WjRvXLQwcltoEg/CZD8nWSHfAOo7TA13gva/dXY+C+rowNMKhCCW2nQ
         RAkbKM7gTM5KWXeMDJYgCU8XxDdVfUz5aK9NSIkNnXEqJZCxx21ZowSYCKvWVFen380o
         7I7A==
X-Forwarded-Encrypted: i=1; AJvYcCWpizkSYEaoE+J0q1uVMcFcVVuevyo9sCPHkz/sToe2ygN8ThEyzhV1lYA5EbUo6nEUj7QefAG/KBaQzg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy2Rfde15dY5K7ufL470xjEzQIzceUgta2k1ScjrG1Nl7O/uFv3
	9x/CGJ6MM+PFbI/J582Cdf3DURhPB6KMnwwqqWIwapmVWc6uJ5WsYg5sKv4SLB7SPCMMovJqKVB
	ECUs0K5wAjTaFK3/NtfF8Seow0NXnNUNhGbN+X1s=
X-Gm-Gg: ATEYQzxc9H7ZH11SUCdLTO2kfpTeqlde8lmTbUONLHrEZI+w2OAGIFYIdmDDExBywne
	CENgHWtdaL66p7mDS0/9jAeO5D0txvvkSg+YDal4zn7xLJjZcZpiwIHY9oP9eIWubZ+zz+Yv6AY
	NPOKJJmw4Ov5hQN982EROtOywV/lX+lVrTxxrhrKyGN3Nti0sbDvP3qm90obs6Fj5ZM7WZ7CGjq
	QLXyW3CvoWuc0/qnjZQ0jGBCQGGPkK0ygqIJccFfWjEO9glT8b6iolauLcjo2X4h8YV+gx2iQPz
	Ne73gAYleOYhn1eFei75W7cJToqST8ByoOVVooT8+iy4Rnc1YMsbPqoYMbdIa+lRQEK4cg==
X-Received: by 2002:a05:6214:194b:b0:89a:7d14:66cb with SMTP id
 6a1803df08f44-89c85a9e4b0mr113926856d6.5.1774196632728; Sun, 22 Mar 2026
 09:23:52 -0700 (PDT)
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
References: <20260322083620.19933-1-nithurshen.dev@gmail.com>
 <20260322085729.24511-1-nithurshen.dev@gmail.com> <CAGSu4WPJ2nvYRUHT-JiPx00RLAmwZS-AzPfzWxn4oiAqLb3zHg@mail.gmail.com>
 <aff41e7b-dc81-4d2d-9298-c44bfb487936@linux.alibaba.com>
In-Reply-To: <aff41e7b-dc81-4d2d-9298-c44bfb487936@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Sun, 22 Mar 2026 21:53:44 +0530
X-Gm-Features: AQROBzASM3D6fS4q5s1GnsugN4MU8BFoUfdbim_GXaJFS27tO1gpkuN989GH5UI
Message-ID: <CAGSu4WOM8GevEVU9NNF=YuwgYYPKhMR_ySvAVFPZCsiz_X47Ng@mail.gmail.com>
Subject: Re: [PATCH] fsck: add --workers option to configure worker threads
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2936-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,lists.ozlabs.org,kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: AD6702E9FCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Understood. I'll drop this patch and fold the --workers
option into the full MT implementation once the design
is settled. Thanks for the feedback.

Utkal

On Sun, 22 Mar 2026 at 15:18, Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:
>
>
>
> On 2026/3/22 17:31, Utkal Singh wrote:
> > Hi Nithurshen,
> >
> > Thanks for testing the patch and for the detailed feedback.
> >
> > You're right about the strtoul() wrap-around on 32-bit systems =E2=80=
=94 I'll
> > switch to strtol() and add explicit error reporting in v2.
> >
> > Regarding the design concern: I agree that landing just the CLI
> > portion without wiring it to the workqueue may be premature. I'll
> > hold off on v2 until we hear from Gao Xiang on whether this should
> > wait for the broader multi-threaded fsck design.
>
> This patch is simply not needed as an individual patch.
>
> >
> > Thanks,
> > Utkal
> >
> > On Sun, 22 Mar 2026 at 14:27, Nithurshen <nithurshen.dev@gmail.com> wro=
te:
> >
> >> As you know, currently decompression process in fsck.erofs is currentl=
y
> >> strictly single threaded. In fsck/main.c, erofs_verify_inode_data
> >> still processes blocks synchronously via a standard while loop.
> >> Without wiring this flag to the workqueue engine in lib/workqueue.c,
> >> the option doesn't currently change the tool's behavior.
> >>
> >> And as you know "Multi-threaded Decompression Support in fsck.erofs"
> >> is actually an official GSoC 2026 project idea and the project will
> >> likely involve a comprehensive design of the parallelized
> >> architecture, landing just the --workers CLI portion now might be
> >> premature or conflict with the eventual design chosen by the GSoC
> >> contributor.
> >>
> >> I'd suggest reaching out to the mentors on the list to see if they
> >> want to hold off on this patch until the GSoC project kicks off.
> >> Also, if you do send a v2, switching to strtol() would be safer to
> >> avoid potential -1 wrap-around issues on 32-bit systems.
> >>
> >> Best,
> >> Nithurshen
> >>
> >
>

