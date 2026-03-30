Return-Path: <linux-erofs+bounces-3125-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O6GDnvCymmL/wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3125-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 20:35:39 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B78C35FC79
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 20:35:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl0LG3XwXz2xSb;
	Tue, 31 Mar 2026 05:35:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f34" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774895734;
	cv=pass; b=ANjTCvvrmNDW4Yb+tynPWv1+piCOK6ucpte3JCBQMlO7ziioP6AKEPR8xO6s72ELx72qQ1d+G2Icwm3iy/oNh9ip+TLP+B3j9K2eV6YlOzBApfckoUWXFptYb3dA7qbyNzwTzl0XQfVnC2U04cisxzK2UbI6ON5qR8OSsemz856QpTJjoJf0VSiCEP7dNkLfe5a1aqq/NPDg6rNruVnUsCrL2OkbonQPpDQ9aOjXVlTLIspzGajZy8dk0oK8cB86HSGTeE7sgqSH6fWaCmVBsWsjkpabDE6yKs8trTV+Sg1tMcFw9ahykn6Ah5uJzvFldZDSWjh2yB2/by0/nZecog==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774895734; c=relaxed/relaxed;
	bh=ugjdP+iVfq1PH8Fw+Zo3KDBd16P3/+vcyzbPXUgeOoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5flsvnXmbHUonPmAZekJFhzYYPSw4HbP7ZwndHsdf2ZTPTF3/FGOg8LWUFMmeNSNUFLvEQ6RCrP7C+DzmjuEMp27Sh9gVIjSTpcBVPN6g4M8KSHj0ChPOi9TJ35eVxjXL+KhjHtnNWSR/c0Cj3AaY3SE16FwsCPb7/QrLT/9gwMYAgcoEKSc282ZFR8P60I5SnRaDL1gy5H6LQHmhCk6n4O8pFjOJyjy8xTn7Q4HB+rF1tNaV0M4OtLh/hOc4Ph1eeYKLjF6WeMt/oF6TizZcnuNQ8SoH77/BSalLMeCV78WmzXNq8nNLgrJkmBHpDPRiPbEtL6AK/tSDwNKMB6mA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lCw8bDkG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lCw8bDkG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl0LF2Twcz2xGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 05:35:32 +1100 (AEDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-89ef9f3840dso2014286d6.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 11:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774895729; cv=none;
        d=google.com; s=arc-20240605;
        b=KEdYSBSNERrOZSBo+yYoJim5c9pSgxjF1jsFtFDQkxDpKpyy7n22edp/jIBfoak3EZ
         AArPbS6hHPwJJHfPYuwewvWsNHtjRx2xnfLxysOSX1UDrqy0hPeSkm7Lp7QiPnqIaY6z
         Y5vd8V7OMsDo66Fx0cQoVHvnuPf/xnQ5h6Vdlu2qegSVCMoNd2AhC/Y/ysXbMi64Q/f1
         ZymCOx87rT/gPjGirWQIBYo/RCqBTymT+gYWjw9PkGO2Nm8U+fqvNg5fjDeT9k05lpQ+
         M28p8EnOPjdfTcLOIvRs1bkFpvAanwPnusw9YtqTuqKviNzT28FB2IUjWXTHpuMzLVVY
         NH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ugjdP+iVfq1PH8Fw+Zo3KDBd16P3/+vcyzbPXUgeOoI=;
        fh=vaE4vsNMvoVyR/yn6s5czqZsrgG483cxb6FYahihPWQ=;
        b=HjwNU36UNLzH4tj8RDMkuiunezXRVZaUJGRZhPqFV/Ttjq9jvz7H3+CxTOrw41ePlN
         rvqd0WejeS6uQaOmZDid+gQfP87Ed5tqL3TzrxyWl9szr9pyMIJ0gRGukioSd4J2YzAm
         +nhNugX5RurXABawq3DxtwEfJyvQ5EfFOD496MYqU9G39pR4SBjTwiJWXFLZ5wLZxY6X
         /T6785BbTEazmLdQw4P7tZffwpS5ucjymjeyPrKFYtSjGAm29X0epOVNlYD5Ss84MouQ
         rLcAes9hronnmd0MinYurXFbb1SdvuCYPj8OxcM/zGHIMowY6jO0PbYeO0wyc6bg2amn
         Qz3A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774895729; x=1775500529; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugjdP+iVfq1PH8Fw+Zo3KDBd16P3/+vcyzbPXUgeOoI=;
        b=lCw8bDkGgchNMyi38uCpkZRPBr2MvqGxTcoxOQEKvTRiyr1T41Y1GS7Q4mBdPjNNGx
         WIuHgX4nzGCRAexXvSsvEeR3BdgjCfWwrPlk4Jk7YtaZEMOrkcNUacMXogJ3wlntjJLy
         zGO5x5RDOmMeiwGqxXJtq6s4NKmVRnHWh2zcn7/9m9gZdkcV4lF+zszqcFMPDdP9lnD2
         NDQSlg/N/w22BI9dsPeRT+PoI8F6RRG/Ppwu/JlvWRzjwaifTQXy+EJD3OPmlKU12bNn
         t6CKKZ2B/Bnprbjj/YjRZaL6j7AIaR2LV1bQ441On1ILshXthLr10kCFUcw3SOPC99YV
         1L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895729; x=1775500529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugjdP+iVfq1PH8Fw+Zo3KDBd16P3/+vcyzbPXUgeOoI=;
        b=RJfevIw0qHHVXPGgfs12eM2AN7ogtplEbGxQqxNl02cApwOouzcDVjgpxuFIDkCqDm
         QJAjlsuHXhBq5Psq7EENpSqaHlwn/WycI7ZzuwkRStD+hlWnI3EyWWSzQzLTay6EhNSR
         gC+IdMRKwcLLR68jX7cz5bdEOkPG7ga+vGOo2EfURyQNuo574Cnrl8LqvtNnQQWiyTJ5
         mTwj+c6Nhp2oUE7hdUvgj0V1lmPC988UOJgZHOt2qxH8NWu8ruYZ11PitTqhQIKf8d0l
         yL9kqN1bpXOe8rlJiYfT9keVoZPCQSzfcSbD+m/n/S8beBh7AsFt9DlFEOzjN+7Temiw
         dE5g==
X-Gm-Message-State: AOJu0YweDjnDneeFt3hL/S9tEPaIpECl6ky6oxUs03RYh557BmEpYfAd
	hDjQsG6LAqryw/1pvCu4oHBYePhYe3aulu2wcgPLIPXgGKZb/HHhJKun9eWvblTajbvfgJ2y8CQ
	P6acG+WfNm+uzqd/Km9tMVRUxbvryrDI=
X-Gm-Gg: ATEYQzznuSVAO4wWlSM49Ljl0hMNcmjJuMo55CwMc2+oyfTxjvtTygWGEBUXK50Tma/
	thmkurBJ6zV7Nz9WgU8cC0UJyWMwr4Gp1GfTvMPdYaYSGK2tBgDfk+or0MMIaKX41TEy0b7o2Be
	23Qb5lUheEtcg562AQbleI04b1tUa1LC7SOPcbiIhOGfT29Nv6ABfKHaP/LcYn+ekw2dYMXmocj
	+S17E1hFyWrsro5MAypd0UhNG9oi123gKrVnUQZqI0fPGRyX/AZl9zU4FrMRDCT14zEz5Xy2R/5
	sZz2tO+uSxaLDljfCs/9YbPw3MhEh3Gfo2RVUtOcVSEXEwmsqwnV7/C4DQK1At12KFxUxw==
X-Received: by 2002:ad4:5aa7:0:b0:89c:cc08:c56 with SMTP id
 6a1803df08f44-89ce8dddebamr148009596d6.3.1774895729218; Mon, 30 Mar 2026
 11:35:29 -0700 (PDT)
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
References: <CAHf8aCXHHLFCghBEy4hF+DoDpYed0yOafvKbdbmDgfjRC2Lfww@mail.gmail.com>
 <CAGSu4WOLGADT4Z+iEw33K1M-1F1Pgu0aHBwk_8R_2tbee6k5+w@mail.gmail.com> <CAHf8aCV+d0-YL8Gt_Xhw0knS7gz8FZB_RF315XOLtfOi4ec0Vg@mail.gmail.com>
In-Reply-To: <CAHf8aCV+d0-YL8Gt_Xhw0knS7gz8FZB_RF315XOLtfOi4ec0Vg@mail.gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Tue, 31 Mar 2026 00:05:26 +0530
X-Gm-Features: AQROBzDN0eCxGNv2LvpVqt9LTMyj0CnZzXgme6wn7x19kIbhmdXt_hcA3MDV2n8
Message-ID: <CAGSu4WMJ43VwWa-_6rvxmjQHNJxOAWfMZv+0jJAy2joQ+6vzeA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC_2026=5D_Multi=2Dthreaded_decompression_for_fsc?=
	=?UTF-8?Q?k=2Eerofs_=E2=80=94_design_question_on_z=5Ferofs=5Fdecompress=28=29_parallel?=
	=?UTF-8?Q?ism?=
To: Deepak Pathik <deepakpathik2005@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:deepakpathik2005@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3125-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3B78C35FC79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 2:00 PM, Deepak Pathik wrote:
> the two-phase model (serial traversal + parallel data
> verification/extraction) makes a lot more sense now

Good, that is the right framing.

One more thing worth deciding early: error aggregation policy. In the
current serial path, erofs_check_inode() returns -errno and the caller
stops on first error. With parallel workers you need a shared error
accumulator and a policy for whether to drain the queue on first
error or run to completion =E2=80=94 the choice affects both exit status
correctness and how much corruption a single run surfaces on large
images.

Good luck with the proposal.

Regards,
Utkal Singh

On Mon, 30 Mar 2026 at 14:00, Deepak Pathik <deepakpathik2005@gmail.com> wr=
ote:
>
> Hi Utkal,
>
> Thanks again for the detailed explanation and for pointing me to the RFC =
=E2=80=94 it really helped clarify the bigger picture.
>
> I spent some time going through the relevant parts of the code and your c=
omments made a lot more sense in that context. I see now that while pcluste=
r-level parallelism is valid, the main challenge is making the surrounding =
infrastructure safe before introducing concurrency.
>
> In particular, I hadn=E2=80=99t fully accounted for:
>
> the lseek() + read() pattern in erofs_read_one_data() and why switching t=
o pread() is necessary for correctness,
>
> the lack of synchronization in erofs_iget()/erofs_iput(), which could lea=
d to refcount races,
>
> and the implications of using an unbounded workqueue on large images.
>
> Your point about backpressure was especially helpful =E2=80=94 I=E2=80=99=
m now considering a bounded queue or a semaphore-based approach to ensure t=
he producer doesn=E2=80=99t get too far ahead of the workers.
>
> I also revisited the design with this in mind, and the two-phase model (s=
erial traversal + parallel data verification/extraction) makes a lot more s=
ense now, especially for isolating shared state like fsckcfg and path handl=
ing.
>
> I=E2=80=99ll continue refining the proposal with these constraints in min=
d and go deeper into io.c, inode.c, and workqueue.c to make sure the design=
 is correct before thinking about actual parallel execution.
>
> Thanks again for taking the time to explain this =E2=80=94 it was very he=
lpful.
>
> Regards,
> Deepak Pathik
>
>
> On Mon, Mar 30, 2026 at 1:50=E2=80=AFAM Utkal Singh <singhutkal015@gmail.=
com> wrote:
>>
>> On Sun, Mar 29, 2026 at 6:47 PM, Deepak Pathik wrote:
>> > for LZMA-compressed images, are pclusters in fsck.erofs always
>> > fixed-size and independently decompressible at the userspace level,
>> > or are there cases where a pcluster depends on the state left by a
>> > previous one?
>>
>> Hi Deepak,
>>
>> To answer your LZMA question: yes, each pcluster is independently
>> decompressible by design. You can verify this directly in
>> lib/decompress.c =E2=80=94 z_erofs_decompress_lzma() calls lzma_stream_d=
ecoder()
>> and lzma_end() within a single invocation, with no persistent lzma_strea=
m
>> across calls. The same holds for ZSTD and deflate. The on-disk format
>> enforces this: no pcluster depends on decompressor state from a
>> previous one.
>>
>> The parallelism boundary you identified is correct. The deeper issue
>> is one level up: erofs_check_inode() is called sequentially in the
>> dispatch loop in fsck/main.c, and each call may decompress many
>> pclusters per inode. Inode-level dispatch is simpler than
>> pcluster-level because it avoids output ordering constraints.
>>
>> One thing worth thinking through before wiring erofs_workqueue into
>> the fsck path: the existing queue in lib/workqueue.c is an unbounded
>> producer queue built for mkfs compression workloads. On a 34,000+
>> inode image, it will accumulate all inode descriptors in memory before
>> workers can drain it. Backpressure =E2=80=94 either a bounded queue or a
>> semaphore on the existing one =E2=80=94 matters here.
>>
>> Two paths in the surrounding infrastructure also need fixing before
>> concurrent dispatch is correct:
>>
>>   - erofs_read_one_data() in lib/io.c: lseek()+read() on a shared fd
>>     is a TOCTOU race under concurrent calls. pread(2) fixes it cleanly.
>>
>>   - erofs_iget()/erofs_iput() in lib/inode.c: ref-count mutations
>>     without synchronisation. Concurrent iput() can double-free.
>>
>> I sent an RFC on March 22 covering this design if it is useful context:
>>
>>   https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K61xoUCi3FB9QR081fNh-=
1hoX1z2TZMk0nGpHQ@mail.gmail.com/
>>
>> Happy to discuss further on the list.
>>
>> Regards,
>> Utkal Singh
>>
>>
>> On Sun, 29 Mar 2026 at 18:47, Deepak Pathik <deepakpathik2005@gmail.com>=
 wrote:
>> >
>> > Hi,
>> >
>> > I'm Deepak Pathik, a second-year B.Tech student applying for the GSoC =
2026 project on multi-threaded decompression support in fsck.erofs.
>> >
>> > While reading through the source, I traced the decompression path in e=
rofs_verify_inode_data() and noticed that z_erofs_decompress() operates on =
a locally scoped struct z_erofs_decompress_req with its own input and outpu=
t buffers =E2=80=94 no shared mutable state between calls. My plan is to wi=
re the existing erofs_workqueue (already used in lib/compress.c for mkfs.er=
ofs) into the fsck extraction path at the pcluster level, with pwrite() for=
 position-based output writes to avoid ordering locks.
>> >
>> > One thing I wanted to confirm before finalizing my proposal: for LZMA-=
compressed images, are pclusters in fsck.erofs always fixed-size and indepe=
ndently decompressible at the userspace level, or are there cases where a p=
cluster depends on the state left by a previous one? I want to make sure I'=
m not understating the LZMA case in my design.
>> >
>> > I've drafted a proposal and would be happy to share it for early feedb=
ack if that's useful.
>> >
>> > Thanks,
>> > Deepak Pathik
>> > https://github.com/deepakpathik
>> > deepakpathik2005@gmail.com

