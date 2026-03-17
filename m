Return-Path: <linux-erofs+bounces-2779-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPfQHf7cuGlykQEAu9opvQ
	(envelope-from <linux-erofs+bounces-2779-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:47:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B72A3D13
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:47:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfbH01H2z2yhY;
	Tue, 17 Mar 2026 15:47:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::72f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773722874;
	cv=pass; b=dlOxxrFo9TzR9MQJgGPs8/6GEBwCG8N27mVp4SvOy0JZKWmAqp4ix7cz4NTtpwez07RfEVeVcI9aHZZUgKfiUSEtngPTxdd/syEOEH3gzwsep2Yk2Krw2ycMZ9lnpXClVx4GpLW+S/NbH5qiCImD/5j9DO1rzgpVaItqEJ7gNjOZxfLsHFKkuFtSLLv5JVBVEpLKUrVDqYLONqQnP9+IN+tNG90dvMYDUPHmj5aBGXMPuoWyGBDi0MB5z89L9nKPc+EKjP8mS5/gNM1MRBu2as/lq8ClNrWF6Hua2YQjM54bY1m1T4ybkAA++mkIeKMLwvyFwPCKEjDu2CQ0KbjuFw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773722874; c=relaxed/relaxed;
	bh=gORDlfzEw4l3a5mKIen+pc4kcWviQ0ciOoY66cPY7UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayh9XlAdE9GHh/8+NhkrNvuCgvfDo9fH4MWYegjCKwGzmsjlxgtINYgdNH+P8csUCAnyCd+RFe4p6j7zTSayMR+1Ak47KWAqUQSEXy/eil282/u5Fki2xe/ytfXW3DNnHYjH/7EdXec7Kbjhbg8iGon6swgqHkRVto6wSNGxwXGLsHkPmiDMujOWViAPMjRqmLjZlKv3IrsuosNum9no0naM+BSi2AlY1D5hd/irXUb9n3UvGibah54yTDiVIN9IxIcETOST/l5lMS7j58UtA+wj2UOz/ej9z7TqvJU/TY5gzkgZGZbTx6Y3xyWtQTFDNCtFrAuzQYP1qSNsUzz/3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Je5I0/Zi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Je5I0/Zi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfbG1Gq7z2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:47:54 +1100 (AEDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-8cda7db840aso75651785a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773722872; cv=none;
        d=google.com; s=arc-20240605;
        b=XEF+vb0jRjDzoNWjJoQ+I1R+HZnepv43f/mrnfh4yFKvl4CgfwiE3UKZXEGNuXVs2N
         0Ky1re1wNxQJCjdM/a31gyEbRduC/1o3Au67BsPw099wLQ4I6IeBuZ8053ux4OzPaJOv
         CLvYuBoP7gXnL4oE2KPhQB6rAXEe+/PlK0WZqmOFb920yOUINlbsbkocVsYTR6EqCocp
         Y/jnxaMQk6VtRYqnyP9RgscqcGca9tI0F4EEVX2Z/WBZ0D3iRqoj8Y1dU1TXEd6Q90G3
         som+ZuGPA+P1ckbAhPqLc2hjKMt7GIIGS78P6gGHARNVVCusyvJZ7j8C9V8NTA7CTnwp
         1FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gORDlfzEw4l3a5mKIen+pc4kcWviQ0ciOoY66cPY7UE=;
        fh=Ti2Ztps5ncTGufxtmxrJu908O7DsJpNW+u8nwQfRTHs=;
        b=InqHv/p2l4BqfzyyvtwP8QyWMPVCXHVK7czIN7EmcIwZks8/2MZMiUFxD3FlkoQbdP
         LzO87sC7eo1gruQXpzGDFYX4zCPUYB58My4Wtzrt0ceCgSXrK70AZdicZx+sXVYfl0lN
         8jEIgeGGPv/TKiE73Ta8p3i1sRYIsahB9VoVsNydIba4V15CHEu7HdE2A4iF+KwbP7kr
         oXly32EzFAsFcAkZLohKVkMlPx16bLmz0HEDLm3WiLE+NX9SjihzSDqoLGcKQPQDXq8+
         K8u3CH6E864viN0V6y30455RbT3VE7M2iotTMDNqdJT/Y/Z25pB9Y3j0pQfyBjEnNB50
         Wo0A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773722872; x=1774327672; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gORDlfzEw4l3a5mKIen+pc4kcWviQ0ciOoY66cPY7UE=;
        b=Je5I0/Ziw7Ov6jCK9p4FL6FK7N4+SuGYitnpbRtiaQAkznbgQB1pFgmFFz7Cb57+lh
         CJ8dtrt3z1xTMkrYq0+N/6BPmxWNuMvvkomMOGDcwg/zXCSD1BRqIGmktHJ11BPFz4rG
         6VZNLYPOboAJcTGJW/+mY2wA5qjAeLxnYWJfToaATD0CvryW7egiJ8pvWiG875Q/6NXA
         JPLwKIVWXQWS4YOgDS7b0NjWb4ofkcDX2pkbigsr4JxMOL0kvRsr4TjVP2r+Sj5pDQbL
         dIGMLUBT/DTnPubZSI0Gm0hACJSGXSChDJOshLvK9YNbpM4mLXj6iUkBBxPiCTG2INGa
         coQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773722872; x=1774327672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gORDlfzEw4l3a5mKIen+pc4kcWviQ0ciOoY66cPY7UE=;
        b=TVt2AeAxTgSGLxNeoYuFCQBespI0FIOCoUn3mso4ZVz24uywBFPS+9w1+ulQC/5/4i
         F5WM4XtzKWoXwmbb/bSJamfAIIIBlW/lU+Y/foDF6vELYJ6ZI87j6XTWvtnrObL9gBQ7
         vCnHa1OvzQMW9JD4rGTAKo3h3nOOBxPSSpu1wde0jd+WkM+YulbBm8fvPrcyX8oW/MyG
         0CY1ky2qX4xC3h95xkE7u/VomSOxHmF0YvDncvm41q4uosFYJtvUMnbA28hqWKfIPrEO
         OGY4mmQ7WXbUXPcDITqNzVr/MXv2VWi6BBFun2KzRZJtYFr4RwaTN5iQLpIpmeQkQDFi
         l6ng==
X-Gm-Message-State: AOJu0YxcrY6DmbdXiZZcldMi9lK63dhnzXwNz/L3hZtwASut7KvNmza8
	8usVbRdxnaAX7JdGX2vGYF+ZT/fxFg72A6Z3q/qy8V0bMGDjoXzu8veSgzU/Wf7SHTxmrs6i5zr
	Ydg4ZNnaEtXPmOk9ZTiga1bePFNsS8oE=
X-Gm-Gg: ATEYQzxA7lAvU1MFi5gddnj9thUwxdAVwHFZnPvkueQpjOV1YTeQTwr1I8vF31zrzU/
	9JJDWVldA1a0RcEwZH8DNBxM5S6bPGIOGd39ighJHBiZo4rBPauz5B153Q5Rsr+tkD9G8ZFA6mm
	CqYsoIKCb58ojNU9LXIYw9tiKlUD+hgKf3RpM71r65lKC4PkKnWOYhjWy2aosNYKSyKvY0UXhGx
	BVQf5nq3kULcnGRjkE3ox8n5czToyTRyk/iY1MxH+OS4gVBx95hJbpD/JFIGDeIbpSrrcEA9Pwd
	yc6H0s8dLNl0evg11CYvNnHC6Px7R8aVgNyd7Aha2qgD09lCxseSavaKCvGDcoZoEZpugBmBvkw
	Nwn8=
X-Received: by 2002:a05:6214:8101:b0:89a:564f:bbab with SMTP id
 6a1803df08f44-89a81f33768mr144095676d6.3.1773722871778; Mon, 16 Mar 2026
 21:47:51 -0700 (PDT)
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
References: <20260316212847.57030-1-singhutkal015@gmail.com>
 <20260316212847.57030-2-singhutkal015@gmail.com> <70da1a5c-8365-46a9-8c89-a3f451a6e257@linux.alibaba.com>
In-Reply-To: <70da1a5c-8365-46a9-8c89-a3f451a6e257@linux.alibaba.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 17 Mar 2026 10:17:44 +0530
X-Gm-Features: AaiRm51rQ8YLo-W0nRGJ-FBoWl5kB6RSkwBqrRzwVXM-kl4YqsS3Ue-EuPYrhtg
Message-ID: <CAGSu4WMAZTqM9OLnU2qfqBdf3Lc2K66h=cLd2G_SdDsVBNwYmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] erofs-utils: lib: validate ZSTD frame content size
 in decompression
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, yifan.yfzhao@foxmail.com
Content-Type: multipart/alternative; boundary="000000000000b3d150064d310923"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2779-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:yifan.yfzhao@foxmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,foxmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 7B1B72A3D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000b3d150064d310923
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gao Xiang,

Thank you for the review.

Understood, I will include a reproducible way in v2 for both patches.

I have also created a GitHub issue to track these patches:
https://github.com/erofs/erofs-utils/issues/47

v2 will follow shortly.

Best regards,
Utkal Singh


On Tue, 17 Mar 2026 at 07:40, Gao Xiang <hsiangkao@linux.alibaba.com> wrote=
:

>
>
> On 2026/3/17 05:28, Utkal Singh wrote:
> > ZSTD_getFrameContentSize() reads the content size from the ZSTD
> > frame header in the compressed data. This is untrusted on-disk
> > metadata, independent from the extent map that provides
> > rq->decodedlength via z_erofs_map_blocks_iter().
> >
> > A crafted EROFS image can set the extent map to claim a decoded
> > length larger than the actual ZSTD frame content size. When this
> > happens, a buffer of the (smaller) frame content size is allocated
> > and decompressed into, but the subsequent memcpy copies
> > rq->decodedlength bytes from it =E2=80=94 a potential out-of-bounds rea=
d.
> >
> > Additionally, the ZSTD_getDecompressedSize() legacy fallback
> > returns 0 for frames without a content size field. This leads to
> > malloc(0) followed by out-of-bounds access on the returned pointer.
> >
> > Reject frames where the reported content size is zero or smaller
> > than the expected decoded length.
>
> For this kind of commits, please add reproduciable way all the time.
>

--000000000000b3d150064d310923
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gao Xiang,<br><br>Thank you for the review.<br><br>Unde=
rstood, I will include a reproducible way in v2 for both patches.<br><br>I =
have also created a GitHub issue to track these patches:<br><a href=3D"http=
s://github.com/erofs/erofs-utils/issues/47">https://github.com/erofs/erofs-=
utils/issues/47</a><br><br>v2 will follow shortly.<br><br>Best regards,<br>=
Utkal Singh<div><br></div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 17 Mar 2026 at 07:4=
0, Gao Xiang &lt;<a href=3D"mailto:hsiangkao@linux.alibaba.com">hsiangkao@l=
inux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
<br>
On 2026/3/17 05:28, Utkal Singh wrote:<br>
&gt; ZSTD_getFrameContentSize() reads the content size from the ZSTD<br>
&gt; frame header in the compressed data. This is untrusted on-disk<br>
&gt; metadata, independent from the extent map that provides<br>
&gt; rq-&gt;decodedlength via z_erofs_map_blocks_iter().<br>
&gt; <br>
&gt; A crafted EROFS image can set the extent map to claim a decoded<br>
&gt; length larger than the actual ZSTD frame content size. When this<br>
&gt; happens, a buffer of the (smaller) frame content size is allocated<br>
&gt; and decompressed into, but the subsequent memcpy copies<br>
&gt; rq-&gt;decodedlength bytes from it =E2=80=94 a potential out-of-bounds=
 read.<br>
&gt; <br>
&gt; Additionally, the ZSTD_getDecompressedSize() legacy fallback<br>
&gt; returns 0 for frames without a content size field. This leads to<br>
&gt; malloc(0) followed by out-of-bounds access on the returned pointer.<br=
>
&gt; <br>
&gt; Reject frames where the reported content size is zero or smaller<br>
&gt; than the expected decoded length.<br>
<br>
For this kind of commits, please add reproduciable way all the time.<br>
</blockquote></div>

--000000000000b3d150064d310923--

