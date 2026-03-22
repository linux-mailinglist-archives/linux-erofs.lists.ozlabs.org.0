Return-Path: <linux-erofs+bounces-2929-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9awyA7yfv2mD6wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2929-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 08:52:28 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82D2E88E3
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 08:52:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdpRq2ZQmz2ySb;
	Sun, 22 Mar 2026 18:52:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::332" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774165943;
	cv=pass; b=a40BFctNXBqzHGKIG8n8ri+Sk9CEshKeJqzt+wp+7N4Rqqa+Z2W+Ih8vLrmrihGmUWf/mOgSWF+qXSJDytavQibE2xEg5WRMxb88M3TziDGsHg7AqKOlFdO6SM4rH5bdycVb+01Fznl9w1CWSa8B5SH/Im91irVd1gjB5X9o8PBLjyZePwId2RGTMTnfhGQqtSilNEbSSs5ZpK4Vhyjo4UsjmZCJ1q1okSfhqqZ5I2ChnYye2agcupg0Pbizv0EZdIrBM8vHtgLq8/zgyFxuDVu6wQzpa1d+s6nP4Q46QNC0ybaXLmpxiK2zLvZh1b4M9O5oORMPrpCK5sHhQa7fTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774165943; c=relaxed/relaxed;
	bh=e0rQj4k0LxPwQPLI5ms9z3h32AgFH5/UgXucCa6Vmwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRy3f7Z5nzdYxN9DUM04ezPSGaRaYE189AdI6nRo2MEtYXPWefniVyBhjs3YNO3OoveoXV/OYnAzHldsNIeqTyo40uy1bYOAEEm1KhbkjuYMMb3hF8Ii4JhX69Q9Axx/r/ra5oQ11HCjGECINPlcxbwT1FbI40jJPP2rMZ6ggBFCWqe3mbjmM03qEzWzrvqmeiQNR7EuQPNEcE7zKbD5jg+4gfbyECD+3yk0iKPrOQwvfBLtG0ur6t2NscMCZ7wzbIwN3uXVkkzlSqSEC64qNYB6JbjIEhD3MjU106XFCxqz2Cs6Tl5z2zfQauZkRZXrzb6ZWdQBcc4VI+dGHgX/Vw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EzNlct7H; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EzNlct7H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdpRn6tJGz2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 18:52:21 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-48541edecf9so32671435e9.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 00:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774165933; cv=none;
        d=google.com; s=arc-20240605;
        b=UE+Gaa9tecbwAgrjr6f3zjgvfpjA3mJDTcGEiuQNQzY16GWZtrZApYL9xODz+mLCIt
         1+Ot+TYaItIv2yLeagJKarhE8otS8M13nLkAHpSl2X+zlL+Uf2bUOXNPni2NtfS4miMm
         /T+0/UNt1ck7yk8klxj6vbkZuEoej/HnjN+h3eUSbUtmuaNR7uc7z+zLmfDQYFY21bDz
         Po9zmBb2b1LCVV45NphLEVhtuQ1uY0usedE6/g0x3gYgYVQpEgAfZezk2LKffxTDTygm
         HNBZWNoQDFwpdLBkmp16rAVyz7JEaJ6y80LwICZw79/LhAxnY5P8zFVdraLTXUyZGOsj
         2ydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e0rQj4k0LxPwQPLI5ms9z3h32AgFH5/UgXucCa6Vmwc=;
        fh=TC8dcaARiPNADrLwL3K5o+mdQHfHCtdWXIMVokGrY0I=;
        b=lVNQqGKDVi1/MslljZ0Q/TMeQGRgGiZzS1tcUxxDuNrW6PIqkXfH68a0xpxYPjhlHO
         Kv/7yQdGTSV/cdA95pkBUjFshG/XAGN1MrrHk5j8gcgiQKNKFiCzj8FoMOwGGet+GqOd
         9tLSzl/pEisVNsAYYzcVfOeURzjyLSq09nKZU20Yx+IcrPKuZqmj3kDWoJI/MvS+uhbC
         xVS18KWy5kh0Acm2G6kvrU5amJGZFTDKUQVPkOS8elVUwM+h0F0cT+RBUNFueN9nT4lF
         iJYkPXxoGNRDA8SHvf7lVBeT8tB+0/YycomBXxRR7EuH/sJbe05xI8BbaqO8fvOxpaSe
         3lNA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774165933; x=1774770733; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0rQj4k0LxPwQPLI5ms9z3h32AgFH5/UgXucCa6Vmwc=;
        b=EzNlct7HtMOneAKe+qTH4IEkDK/ccIoJBSlA1CIUTgEEeGlE4pOkHBMH2k0XC083SU
         V6x1ZPS8Ex3NIuDTeeBUqO3LfQYA53OR/xo/zS7hfRgSgPjElykCZCarxL1u86TCifq3
         AF33bUpyVXGiOrs/SopWSEGffmawdq0e9jdxzn45VMos0LG3pw6rtApYIOT8zIBeCIUO
         +6T+9gY6a1b0hd4FJj1bdfrD2eaJ8eg2ZgwKz1oA51BNqhDCQKlp0a1KMHgMX0pDFr+h
         vs253BIXEKFKFWIaAeOcFInNyh6aIAhk2rDncUF1ghVfHaf6YzfYhekfETgyVW0GXz2U
         fghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774165933; x=1774770733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0rQj4k0LxPwQPLI5ms9z3h32AgFH5/UgXucCa6Vmwc=;
        b=Grk8LPoC1s3ojLsAm4VOAEKuE1TIYM4p3eAcU9nJdSngOAxNdTtCuYQektvuxEbWXs
         85u+F1ngSVSIJBINoebFrytq2oUETUzJmc49AQBZtXpp8hXnU3BMtnB99I8uhfN0keMG
         SI8XXxFVY0pn+cN9LNqiwBPuJ9/VHcEXepk5InMGxebSM0V7NwC9AKRjwz2LMAlbBq2B
         9rIa/BuVF//zMUn2+ZsEzS1aGQdqf8odvLPBDM46C1HxhwbHdCeatQsu6wf1mce29y/a
         r239xLW2I69CdIZlij4ttq/d/keemq+Sadwi/9Jo3A1XuGrSTaLnFnjnp4GuetNr/ByX
         EPqQ==
X-Gm-Message-State: AOJu0Yy3Y6GPeZEiDXWJ3mZC/r7Wq+ql037+xlkzwxRple4vdnW9rBHv
	aFzHZ51MQ9NOjgr3ZLAbQOcGD7uzRtulWk9RyZNzfbtwZGGIfruA/Ifjein/RTJ6JkWMkNCxRd+
	Mqu/TwqStARJE3IEfqc3YhvwU7t4/Bms=
X-Gm-Gg: ATEYQzzf8FsngiCoG9rZ1NoWUdeKAdk54KsNrjI+AUrkOSzLkP/xDhRlEUcH6BXO6Ns
	qEaRStoL/jT2enGMacHY5h9wZ8VVs3MqBxQHAGtbg6RZjxuCv8zMkPTvdUbCxVgBATu3tHWCiZP
	vgxA8SQxE5DeNGWWOQBaZhn+Gtr71LmwOAvarNox2gUb/xZ7IFjVUyfflkgeIQpNxrnU7EWKInH
	zitNc5j2DnSG979GQsY5SVkpHFxfZ6uVwpW2usHZ2rsNUqQWys6dFRZsACiY7Ynv/tbgFLX6Dar
	fgtFUOE6XVfPr6ZBPaSMlRPgzeMHOragIhQl1JF1
X-Received: by 2002:a05:600c:5288:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-486fedc9a5fmr125587015e9.12.1774165933317; Sun, 22 Mar 2026
 00:52:13 -0700 (PDT)
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
References: <20260322060358.1495-1-newajay.11r@gmail.com> <20260322072608.2656-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260322072608.2656-1-nithurshen.dev@gmail.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sun, 22 Mar 2026 13:22:00 +0530
X-Gm-Features: AQROBzDbTaYu7OS5MWVmxtFxCERxYhMQ2ILXKpLw092Ao8EQo-_EJ4DKEn9xk-k
Message-ID: <CAMhhD9jd7wcKtCYXY7Hw5qCgMZ+jsRe0t_d34H9tjSVSgBKavg@mail.gmail.com>
Subject: Re: [PATCH v3] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2929-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0C82D2E88E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

yeah, sure.
I didn't know that, so I apologize for it.
I will keep this in mind from now on.
Thanks,
Ajay

On Sun, 22 Mar 2026 at 12:56, Nithurshen <nithurshen.dev@gmail.com> wrote:
>
> Hi Ajay,
>
> As a fellow contributor and reviewer, one small request.
> Kindly send the next versions of patches (i.e. v2, v3, etc.) in the
> same thread to keep the mailing list list clean and easy for
> reviewers to follow up.
>
> Thanks and Regards,
> Nithurshen

