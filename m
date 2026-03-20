Return-Path: <linux-erofs+bounces-2893-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNuUJwyYvWl7/QIAu9opvQ
	(envelope-from <linux-erofs+bounces-2893-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 19:55:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C382DF985
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 19:55:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcsFN6FzKz2ybQ;
	Sat, 21 Mar 2026 05:55:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::431" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774032904;
	cv=pass; b=VfTwTqR6vmSKyKZ5yGMrDRu2TEr6XkQv8qof96y5mAnMZWvDbFO0H2aJpQTGLCKma+QHbWYpTi49Z4itbkItT3Pjdqh5tF7jZAYNr/PiWuphnIt7hOVpNb1VYD/tvb8q1XApjT5uE7NwNr5rC5yf9pZJ/JACqHWL3vwTMfpVEGYwvu3jXpzoEPPs8gh9iXxFoWmGGnlmn9ZblmQwNqW2QyvPekP0Isj5kN4bQLPnkNoelQyuy011n5Vo54j46MFYREIwMBLzvOYEYvhiOwWZSSdM9npOQeme3zi/gyntaj7RKwv9UqlhLc1Gvse5Y3MPusXzJtYwVfwcCJhHc9/anA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774032904; c=relaxed/relaxed;
	bh=gF7pvEZO4VZitodIEla8AcbWZAH2qdZEzlbpYAbYOaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asuZKzSVzj0rJ56F+KkcOWLYP9s7kfuLJj9u3cqOPMZ7hgjIkvvhBkZUVwDO8CG2rblY2FOdJ8iJWO1Xraybkihi3k/eKi7AOe9gHNxERQN55KdZkK2J4LTjga4ns4HsxQdWXlRQxkbu0msR8xqNlrw38DIFCtT32PQCZLVTwoXU7ihH9gnbR+ebSGcXf33dEIfETNan555lWgAfw/NetMkpfVkkfFHGhb0G6Aa8KDeD6bYzFpCH0S6aUpiBqprGognnvOhgvly5TIPYWsWkCWAyktYHcs0v/3kH9/l3bOZukzbSL3BepnUeTaENfBvq6xWZ+cOS4mTT+bjnWIuEXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BPl8YEeb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=BPl8YEeb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcsFM5Ywqz2yWK
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 05:55:03 +1100 (AEDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-439c56e822eso2278322f8f.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 11:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774032900; cv=none;
        d=google.com; s=arc-20240605;
        b=Kk3JdIdT/hjyUD8D0fjV+BFfLHX7L0FlpVGfWQWfDqulJhzjyd7vPZgfpIFW4F61MT
         KD7rJ/8QFaTYbmX+kbxa/4sUhsWQvBn0fyJQe/qeyVAcliwKPVWobuGMh3AOKaH3Fvid
         DUY00pzCnyopQPdT5rL3ilEvLOKxUBgX8eDtCxjghngi3WLFvyVlqPeSFo6DwxiI9hAq
         9/FsAlcTorVmf6JBJu90YI0wqcTKeK9EOt8Akw5a0bJxTQe2Tv9OQfl6LCb1VWdO7xH+
         2ZWgYguqZn/ALwkTIVD5ae7blgZ+rKZ8WYrarnsVFUeuwAjgEgof6s0SW1kCrcnGOJde
         rkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gF7pvEZO4VZitodIEla8AcbWZAH2qdZEzlbpYAbYOaY=;
        fh=ROft3vWVbNwhsAvdsBxoFvIsn3sUGWh0Pj0JH/Mj3l0=;
        b=gx6Zps0R+ELBFcMCJqk01J7pll9StmFVvyvmsIitlfYdlyR2qnh28RABc8/kIJuS69
         g2djo3iCgUKRwPp9UV0fvPpaUskW1gK352xr1UYmdIezyE7sHFTtr+NEMws59gk3zmvz
         coJGWINSACbaLIBZVZR5ka/BDjREn5yGWaWMm51bK8zxd74bmyIZ3OzXAmGrSI10xh6i
         +/+fwFBatn/gNuMf3Im2z2DXREjutZasW901F/WO3jDrn0MIh/ZRcmW00wnAQGxTEyqc
         XSaNta30WgNswRlRRQXkBScBExTCIYwh+hmCdTnb8f5Y2tFvEqP7g/hHFVLnRzHj6sPi
         muVQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774032900; x=1774637700; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gF7pvEZO4VZitodIEla8AcbWZAH2qdZEzlbpYAbYOaY=;
        b=BPl8YEebmLqXwQ/70YNU0U3zEFR9bin0cOaVgmkU0kl/bdOgh5VOSZpw4sP6Zi5vXC
         s6lvZsHWcy4F8PQRixOW2rrpDCVIidoI/kXT4QNACSPWgJqZWcvjTkHRmgP7ZkxbN7GC
         +CiIC/em3kvA8sTDRPo/vRmaJJ4nI13pmdE5/P8XXclUP5EafrftK+CFc4vWHHQwyxNt
         wxk7EWGmfHg8clnQNBbtkAS1T3F3PJKLbBjm7qO3iMaJDaORXMT74INDF2CZbxcb1xkW
         SNthNfpIk2RT8LiZrZIP9mj/T69v4bG+g8qzxMGsQ2vfO67iClyML4QfczjB0tTVTgl2
         hJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774032900; x=1774637700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF7pvEZO4VZitodIEla8AcbWZAH2qdZEzlbpYAbYOaY=;
        b=pio/WT10wjHP7WqW9fj4gf2nbXwuuiHg0ebMU+9PCE6PkZUtjEBhm7i/4J13uFiBMH
         SpvVBQsaNrWYvLY9h6vPJPhAcWG5HBh8m6IgIFd+92W2tzuVNWrumHhdQHUxlgrb+WQ0
         vTyRLaKNIuellORN8ySG7JY9ZqcYsYqKzAt2LNZARRIpJ79msn/2H9UaXysFwZwf3crK
         iV4g/RkPCj6f2CHbypkcxDolTJC3Qfl4iKx5i9XUDRwlaF5vULpLPuvV0/l4PPIVTqG4
         PlW+KWFDQr7Ta/ZqpOrrChz3YCtNHRDpK1MsbI/s3ZSAa3M/VlJmiMkPNlUP8eRw+JM9
         tYXg==
X-Gm-Message-State: AOJu0Yy/MAuPf8w8NhBeQiK6eKlFbNYAdDa9g9koYezrI8QMyYMdkNRD
	RgMuFKgJG7kNgukY6VjiglFzeK/cWo422glOHgGEL7RWWrCq9MAPkFzdD14gcCPJWjgppvwKiCK
	qTtuejyYs+LHd8GrMkEbYwgN4KEvE4Jo=
X-Gm-Gg: ATEYQzzSqnbj+3BhopJMGUd69pKP5cPrhgZkXkII2rJbbqtoyv6F7T6+BlvqNq0lRka
	to+TlRNoKF0kxaCzR5y/oBPK81G9HZy8ZHrQIB26ba4Cmp6/ES68gSMTvDpQ9ElHMSmqkha0Cxz
	vSLOJIN8Ntu7aCbOQJHZBnJwmA8vMaTRwAUyLuXHJ+b5NA5eGZiI/dkFNPmpi0M1JFGDRm27goQ
	lRUKcptafjFx2C7fv3AucEB30gq/hxthTzNLjs4TG8e+zj+KVXFs7wENWMquKrgNpzSSUc7Oq9/
	HBa6+9uYVHLUa1lic6w3HS3AuRyvqGEXZd/xTRxSew==
X-Received: by 2002:a05:6000:1aca:b0:439:be78:e1e9 with SMTP id
 ffacd0b85a97d-43b6423fabamr7706219f8f.14.1774032900342; Fri, 20 Mar 2026
 11:55:00 -0700 (PDT)
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
References: <20260320002052.238-1-newajay.11r@gmail.com> <0ad48452-f67e-402d-9a7b-073a645d530b@nvidia.com>
In-Reply-To: <0ad48452-f67e-402d-9a7b-073a645d530b@nvidia.com>
From: Ajay Rajera <newajay.11r@gmail.com>
Date: Sat, 21 Mar 2026 00:24:47 +0530
X-Gm-Features: AaiRm52HAzweVd5fCIrQgEexvdCCmOPvrpLfR5NjpARGWyI3TLLBVoH-t05uHKc
Message-ID: <CAMhhD9iA9y=AhFi-a0BsnkiWZRT9-i_FMKoVmc645hi1UWEe8A@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix infinite loop on EOF in erofs_io_xcopy
To: Lucas Karpinski <lkarpinski@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-2893-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.971];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 86C382DF985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Thanks for the review.
Okay, I understand it now.
I've just sent out a v2 patch incorporating your suggested changes.

Best regards,
Ajay Rajera

On Fri, 20 Mar 2026 at 21:01, Lucas Karpinski <lkarpinski@nvidia.com> wrote:
>
> On 2026-03-19 8:20 p.m., Ajay Rajera wrote:
> > erofs_io_xcopy() has a fallback do-while loop for when the
> > kernel fast-paths (copy_file_range/sendfile) do not handle all
> > the data.  The loop does:
> >
> >     ret = erofs_io_read(vin, buf, ret);
> >     if (ret < 0)
> >         return ret;
> >     if (ret > 0) { ... pos += ret; }
> >     len -= ret;
> >   } while (len);
> >
> > When erofs_io_read() returns 0 (EOF -- source exhausted before
> > all bytes were copied), only the ret < 0 and ret > 0 branches
> > were handled.  Since ret == 0, `len -= ret` is a no-op and
> > `while (len)` stays true, causing the loop to spin forever at
> > 100% CPU with no error and no progress.
> >
> > This can be triggered when building an EROFS image from an input
> > file that is shorter than expected -- e.g. a truncated source
> > file, a pipe/FIFO that closes early, or a file being modified
> > concurrently during mkfs.
> >
> > Fix it by treating a zero return as an error (-ENODATA) so the
> > caller fails cleanly instead of hanging indefinitely.
> >
> > Also fix the long-standing 'pading' -> 'padding' typo in the
> > short-read diagnostic message of erofs_dev_read().
> >
> > Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> > ---
> >  lib/io.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/io.c b/lib/io.c
> > index 0c5eb2c..583f52d 100644
> > --- a/lib/io.c
> > +++ b/lib/io.c
> > @@ -430,7 +430,7 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
> >       if (read < 0)
> >               return read;
> >       if (read < len) {
> > -             erofs_info("reach EOF of device @ %llu, pading with zeroes",
> > +             erofs_info("reach EOF of device @ %llu, padding with zeroes",
> >                          offset | 0ULL);
> >               memset(buf + read, 0, len - read);
> >       }
> > @@ -665,14 +665,15 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
> >               int ret = min_t(unsigned int, len, sizeof(buf));
> >
> >               ret = erofs_io_read(vin, buf, ret);
> > -             if (ret < 0)
> > +             if (ret <= 0) {
> > +                     if (!ret)
> > +                             return -ENODATA;
> >                       return ret;
> > -             if (ret > 0) {
> > -                     ret = erofs_io_pwrite(vout, buf, pos, ret);
>
> Change looks good to me, just minor nits.
>
> Don't need the nested if and I think EIO would be better choice here
> based on your description. We would expect to see 0 from erofs_io_read
> when there is an issue with our input file, mostly caused by IO issues.
>
> if (ret < 0)
>         return ret;
> else if (!ret)
>         return -EIO;
>
> ret = erofs_io_pwrite(vout, buf, pos, ret);
>
> Regards,
> Lucas Karpinski
>
>
>
>

