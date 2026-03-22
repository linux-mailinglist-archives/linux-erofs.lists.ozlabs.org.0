Return-Path: <linux-erofs+bounces-2926-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLK+LOqGv2mE5wMAu9opvQ
	(envelope-from <linux-erofs+bounces-2926-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:06:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4192E85A7
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Mar 2026 07:06:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdm5g0WvTz2ySb;
	Sun, 22 Mar 2026 17:06:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774159590;
	cv=pass; b=N/oXZ39IVNutIDnApesSM+MQZqfViHrXp8qy9L8uEDzqV/G7NjGeh33vDA6u1MUmg43tm6dfouhTwMpgJqpEqp5X1RHU/hz7IT9BM9SsFqlSpUuSaSSWVnyDcYa8nwEQEarZvIHy1MgxtCIWs7Z3jk6kx8v759IKAnhS/umgihK/MqJzw0p46oWsNjhxSaLu4w+DD2j1JQPI8K9e0DjvZAnTmqETkW0zbYw7lMo0AO+JBmAAtoJQ+BopKyoA+loGNowLrdWW6lj5yI46h++fEDRPHfwKGTHv8Yw8QNhH4C4z3AAyHsAANaIXJtrxhOv1o7c94R0r3/sEEWdbQSWwxA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774159590; c=relaxed/relaxed;
	bh=M5vB/PvL0K9yN1I0kCqurq7fKUU3GVqAY04Yn+4G/vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofT5EbxDdoYM2R1+V9nYQgUdUXJNX76kzYooRef+3vPo2yHO+VMtbLFFfkt/5tYu3xpwi0HzAJ9ZpJHYM11+/eYeHcPpkgj53ZOfn4ojdPU2L3G7rWtyXj8mGpw/fDq6xWtgVRwfxqMku8lQ7iz1Eh+Dl/PEvPii+uXop/h31j2zhCBZasPLv7Ykxq9DWyIQt9EiFWV5uJqd2Dqg+j+gfZV2d81MMz+Pbm4NcyydDICXazdDVxeIpk3ihPs6hMEJv4onMTZGvI8U8kj0q1Na5bcz7Z+HjmKPjPX8APcAo5nVu2UHZINlHKIIuoN6sgtNxTs5h65Jqo6c6RCI1c/eBg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B4I/gGKc; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=B4I/gGKc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdm5d6BKwz2xlr
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 17:06:29 +1100 (AEDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so2889121f8f.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 23:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774159581; cv=none;
        d=google.com; s=arc-20240605;
        b=fmLf8OUIAldBsA9nDycC91vrpGhSQEeoGszDpWjifGtFF6b7i4L7gumin4R1o7FL1L
         JcdYhWN+5LaIWSFnJCG7FrYlAKmdnglQVk7cWLsT6RGwn4/hMyrrgribFI+Ch+i7PeVk
         TnOzc3qqHU1DQyzDojB+vMspy+xZ1qXavNpwObi7Ksbw/kkME79qVa3LWWiYWXGv7d8W
         Q31gWUlWAAP5F3BttRRtei3+CzSEX9mBG4l7i8w/gFCl51Hkq32EhFWU+qAhJS0c0HOt
         wrAC4+wkAFSctlFo1QW8MGJUcJDa8xlB4ciTPpN7uXa6mtVisPa4yt2nSwhm4bwWNC1C
         IgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=M5vB/PvL0K9yN1I0kCqurq7fKUU3GVqAY04Yn+4G/vo=;
        fh=CHgk8XXyZs+IvicL4UpQYnytS7guFdhmqOTH0O+QuDY=;
        b=AFLSgppxYL3GbcX2WhF6FUYSrZK/jVJoYPSorjR93TawpcB7LwqezFRxpRSqhALs07
         f2+w9/q4bngFX60OfYEw2RxfEG1ahHjLZKwO2HE8814yzkuFpzUjziJ6FZ21IC1QqjMB
         zs/7EVOubYfda3I5vgoN42K5gzLcMNwIpPI2Pzx93CpL0pBspFYPaCiqeWlncKYH+v0J
         Ws1ZTOmkx4RV0eFTI9xzGrTC5W/DwQG30ZnsiZyb9MPpXvWtxuXx8e8Ns3e0YPFWdTct
         /LgTtU0+0llmlfJ0Afy5cXKN1vO+kHO4yv+JnMA9DuXObnd2WhqqICDNk1g+pZ+uNSId
         mv3w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774159581; x=1774764381; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M5vB/PvL0K9yN1I0kCqurq7fKUU3GVqAY04Yn+4G/vo=;
        b=B4I/gGKc5ymQoMniUqrCAlXayKn224Kexi+IQt4KBU5BrY+yAkxtfzAcp4++VVYUP0
         Nt2gggJy48isO9arcTczL1nkO4bXLcqvnGPxboy2Rdd0hceBXWdflTwmvTdOgpJbS4Tw
         X9deuscHH+0tXMDgUzYm8jeL6WOapnU46YWv8Xcosu3qXuFWSxQobWT8wb1GEM5VmV69
         a1JtuuXbPAUmB1FN7txrnVp23rv0kzIWXq71rJg6sOnp/KdGgH/q138rSxpEL/kt7FDX
         okVBnUdARHLUtX/vVF7mwoyVpTWV4R7K4BgAJs2pE/RgwlhPjg9b6WRDR2Ne3Ktu/ct/
         Nybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774159581; x=1774764381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5vB/PvL0K9yN1I0kCqurq7fKUU3GVqAY04Yn+4G/vo=;
        b=Le6pwM2pKEMK0BkAulGeD7kDMYG7ALYLoRv258rhzWbUXPXLztIxzxUcXXMM6tV9Wu
         lOv/LZ4E9p7He9n9n1WfON7+AQOqouz2RkW4M2103GxQoiNBqDpixYsYgLdX82mx90pC
         qrBfXSuEsL2NbIm3Glmptor1YTLKFq/kE9lJZSFjlI1i5NviGGZgWgBzag7LwMIPHGtt
         hg+BgV8sXKj6j6isoqfGcz0u3E+PtxrQPi5Sn+OxUOcFAbv8LKI1tiWvhOEKePiFo6bD
         4W9NvYWyPnfLSmLd+zig3c+GXhJSEiL7uphkl2SK4bt6aVn3FQaUNB0+nEQRb39Sg88a
         VUvA==
X-Gm-Message-State: AOJu0YxMdVRX843if3ZMzwAybnnd+u4rIfMzzC6p67FeUSfbwUYNFYD1
	uWcxi9A0ySUl3qBMQ5Jam/7o0ocy4SaEwk/2B8GotoC3GrGiEl8Z8XOZ1AIWYM5MGtwSuyjqNZ3
	BuVet4wowEgvswYLDXKchiMygScI/wVg=
X-Gm-Gg: ATEYQzxMt7qNSr/ymhm10UkIN5DX5OA2gZ1mVyugrH2x35GMQkRRoK9QQmmX1RdQsXK
	pZLgpaHtiutwLc/mPG09Cexrm8Okw4LJ8W2LRbqpCcyMcm1F59b34Xug1pxXMWtk+CBTqz+KfqC
	jkZ0J0qPR2JNkOacShjiUonGVhYA+q3tY8s57fIeDIoqgJ3aaxp3mozhrGHpFKA6Tk2ANMRWSis
	BSrxR3NM9nOMryTUwbQfB4y53MoGF85LuCK9EnwTstJAUPAbRhhoy8gxJJhUUT6f1a1k72q+NBg
	eBCs73U7dIZwDnhX943RhXRjG299eevRoiz6svqb2dlSDquRbg==
X-Received: by 2002:a05:6000:1843:b0:439:cd10:192a with SMTP id
 ffacd0b85a97d-43b642879edmr14225162f8f.26.1774159580638; Sat, 21 Mar 2026
 23:06:20 -0700 (PDT)
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
References: <20260320185034.1008-1-newajay.11r@gmail.com> <3bbe41da-553b-4a28-95e4-376963da97e7@linux.alibaba.com>
 <CAMhhD9iWO7p+wSG2D8F0r6RAnfVLComSjjt9wZwCc7hx60ZJzQ@mail.gmail.com> <0aa12846-f5f5-44a3-8370-b1fd74ebc529@linux.alibaba.com>
In-Reply-To: <0aa12846-f5f5-44a3-8370-b1fd74ebc529@linux.alibaba.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sun, 22 Mar 2026 11:36:09 +0530
X-Gm-Features: AQROBzDyGGpsFviCW7cNs9dgWM03gQx6VsrJT49yj4fBfrb2ajB6XXMopJqAqbU
Message-ID: <CAMhhD9gez+yddJM1ZutEcnB-vXtrM=++xDYvxJOy8US54vvDFw@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2926-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CB4192E85A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

yeah, I checked it and you are right.
I have sent patch v3 to fix this.
Thanks,
Ajay Rajera.

On Sun, 22 Mar 2026 at 08:53, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2026/3/21 11:42, Ajay Rajera wrote:
> > Thank you, I appreciate it.
> >
> > best regards,
> > Ajay Rajera
> >
> > On Sat, 21 Mar 2026 at 08:41, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 2026/3/21 02:50, Ajay Rajera wrote:
> >>> erofs_io_xcopy() has a fallback do-while loop for when the
> >>> kernel fast-paths (copy_file_range/sendfile) do not handle all
> >>> the data.  The loop does:
> >>>
> >>>       ret = erofs_io_read(vin, buf, ret);
> >>>       if (ret < 0)
> >>>           return ret;
> >>>       if (ret > 0) { ... pos += ret; }
> >>>       len -= ret;
> >>>     } while (len);
> >>>
> >>> When erofs_io_read() returns 0 (EOF -- source exhausted before
> >>> all bytes were copied), only the ret < 0 and ret > 0 branches
> >>> were handled.  Since ret == 0, `len -= ret` is a no-op and
> >>> `while (len)` stays true, causing the loop to spin forever at
> >>> 100% CPU with no error and no progress.
> >>>
> >>> This can be triggered when building an EROFS image from an input
> >>> file that is shorter than expected -- e.g. a truncated source
> >>> file, a pipe/FIFO that closes early, or a file being modified
> >>> concurrently during mkfs.
> >>>
> >>> Fix it by treating a zero return as an error (-EIO) so the
> >>> caller fails cleanly instead of hanging indefinitely.
> >>>
> >>> Also fix the long-standing 'pading' -> 'padding' typo in the
> >>> short-read diagnostic message of erofs_dev_read().
> >>>
> >>> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> >>
> >> Look good to me, will apply.
>
> This patch cause a regression which can cause build failure:
> https://github.com/erofs/erofsnightly/actions/runs/23392598146/job/68049898517
>
> It can be reproduced by:
> $ mkfs/mkfs.erofs --zfeature-bits=78 foo.erofs linux-5.4.140
>
> I dropped this patch.
>
> Thanks,
> Gao Xiang
>
> >>
> >> Thanks,
> >> Gao Xiang
>

