Return-Path: <linux-erofs+bounces-3110-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPGyH8k0ymnn6QUAu9opvQ
	(envelope-from <linux-erofs+bounces-3110-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:31:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919633572E5
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:31:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkkwj6RC5z2yF1;
	Mon, 30 Mar 2026 19:31:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1234" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774859461;
	cv=pass; b=CpegPl/XHEQViGpnro+tXWsQvcxeqgpmT1QyQCf4XPFwTsQxHu1rir01mLM45Zyl7VEH17DDGjEyD+b3QCv4aN6dg3/r0gY4WcEp2KVKwMmV+C+NU7wCPVCeNe0xPN3xXS4qbHDdrAjyJYqfv+iXtgDfPhFMbcrVorjJB33UijIRWNs6OYP8VvOhC9wU2eoUvxfMfq1freiZIZEw0HbEMDCYT5Wsn3010m1VEiVVR66DsQFlRz5JRzdZlDrsJJQSEtcfz4LiMRhcW0nvF7ucHbNwGzcFuh+no+wWG/Lm/7IRJLkjbdo+9tUJXBxI+w+emH0pOkfz+emqfjMCel6PoA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774859461; c=relaxed/relaxed;
	bh=qtk4k0CkoaM3EBO/yaHnjpE0vtAKzKX0hNipU8DeGbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQOkP9nR+RHJfPeNyIy77ZPtrY57SSxBf+UXpuGIbOAx6fbXz/JwvIqAQmDE0HgBWsVwGw7Zc/LsQ4WSJ3ApeKR9RQ9kHC+sdklksq5uj0DYui0LHrZk2AawVHO27zjNQX/P7PYqJYnKUteZK7jUjUxDV8uLmx546yBG1apTMc0QeJWwy5SzTtdw2J1tCjbmlO4JDFBzwMPTEuZsRXnb4bNr3mV6x8US15DdQQbZQOFk8hmToXIYc1lTupU5kIHE2RvELXDqMew6mDOrmbfoeVtuNUKKgG9CWD/Z57Ri7qiqeTb75fnW7fPQISdG93yGLb2DMdghLr9m1Q/an3SokA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EBHL6QAY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EBHL6QAY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com [IPv6:2607:f8b0:4864:20::1234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkkwh0Vmqz2xpt
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 19:30:59 +1100 (AEDT)
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-128e4d0cc48so4930297c88.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 01:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774859456; cv=none;
        d=google.com; s=arc-20240605;
        b=inf4WlYoFh+yH4UKLpftvz87dgM1FaWEQS8dgRyRGrGJwMI8SvFqyrqyYD4ovhwZTd
         ef1GGmatqoCJ7O2msc9BN/KjH4vtnAx6XOrQMV4s+rSnjTouCzT9qxh11Whw9tQR9Mxk
         Bo8AF360dZDGITmeDRTwGIyen/RAm+wDZK895N7s4E6A3gz6ABw0v06589Zfw2KIludn
         7NJymsX+xOy+cf/VyjTCN4Ul/GR0H6XH9OZhi7MfyGpxGZnjFIl4gSd4jTAvFDLjHZF1
         OBTpGsOl2ebtAdVYvDxuco6ESHqm9sene/jA69Ab/vyGatywDIb4uj3rvkKyXQS89n3R
         +8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qtk4k0CkoaM3EBO/yaHnjpE0vtAKzKX0hNipU8DeGbc=;
        fh=RlfH77I8/Kt0ZrtXOcpno9ZseSB9F3859mFc0m4jdXQ=;
        b=d6ynKtF6rYLRx1dCCMBXSjRhxHvQjMHA+MbHly3KMdtxJl3je54uHGEwAisJUmQSDj
         bIEIROmK30n3VpKqQqdl05qJvtJ4+nKCDamqUnMDI8ftd1S3bNblcLbOlA36BXfeYJEt
         TQEOGuQD2X9Cu98WDnj6ADJtgn5fAzwRXaPXR50IcMzuw7IQ6ZZEfNoaEaMHxiekgJiC
         +KaQnnn3WqXfp9AKHiwmXrKsrKH9E4k4wlPFkR9uf0sglKPQrWyE08BTeZ6MU1KQOte7
         RwUiRE9nqVaItuTMGO6X2vVj9MTf7ulu7RpstpTModAMFsV+OYdXOR9I+Cgon12qlFhJ
         DL4Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859456; x=1775464256; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qtk4k0CkoaM3EBO/yaHnjpE0vtAKzKX0hNipU8DeGbc=;
        b=EBHL6QAYmExGO0FLmWqlLVE6ofX27kUpVduhYnajarxDqvaREISwERqAjpOIeqhf06
         tnkhlw6Bd9ek1dGHjEM/h4pLr4kRzEQ2S2zLL9YxxlinTc8w4gg5851ppWgONTVGRTsQ
         Hdo01htqPSpX5Us2F9LLV/+M8h4aVEL9fQfoshy7Zqm5+Fo+bjIJoKrj/e8K1BvpcV0/
         1BNC/jRh7p4pawPr+Mu+3zJEik3D4onmOEIYXZafJ/yKP8DS89oJgmLb4GsbMr5fGgyC
         iPw1vL7zQu9IMYazmHU+uYYsufKS39sPoo1uCP1oS+Pt946kxsxGUu4MkW/+rCcTmspe
         ipeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859456; x=1775464256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtk4k0CkoaM3EBO/yaHnjpE0vtAKzKX0hNipU8DeGbc=;
        b=QMwVsX/FolWuAP1tF3Dfs76gwnpB0wyDvnI6+eJhzIhuUJRGnJvGMrSNgBLqRbH3+t
         BouRcHtCiBcXUX+/BTx7w4UM1icPJkQPG0Nhom12whfkC9BtQqBzPgi24ONUiu42AGgC
         fbinupXPvtDPW9/xsoyGZXgjbVi63Ihb2f/TQnlNJJc8RmvWS0dRtMMPurH98tx9jJwm
         RuEkBpVdJiUVd19zsAIpiEZwr7qhqZPzpYVhnsEIN59MfCl1bwjrAUBmI6fmgNaP6Cci
         6IkpbGQGtPPwC6hQdN7uM9/nZQXZ8f9TjHC96cFOBT5AjTSKv/776U34q83ySyb3MeI2
         534g==
X-Gm-Message-State: AOJu0YzIgUVvoWhzDDXy1shdB6VA9y1H4shQU2Bk+wrIXBdqcRpPHiQg
	o4aaEqMzkFZMkWAt0sF3gxFCPLKDysnqUy3Vi2eJUob2LQ+fG/NkQe/3KkEvKZ0J1bsxaP9f5Uz
	+xmMoq7xvX5COdZMYH+r/FitsiuvqyGY=
X-Gm-Gg: ATEYQzyccDJWPxaoh++Eo1Q2zmSVj+aNSqw/iEsnwxpTZYfDlLiJu4qNhia029H2LGM
	XlMPIzwtWvlWMpAnNKPahIzhjTBbgNTgt2BMd3ocnm0Eusbxzdh5/twGVFebNjU4ZCSZVt+ms0U
	3ya7iTJr6V5rj5W3estE+pohc6i2Zh4xaOQLrTLX+qwqJ3n6Zd6+JLaviSzeY7B3IEub8Aqn+Eb
	gbzvnC0rY9QRZsLneutHgVoazuyj3f/ALuCvLYOS/K9FgTZcvL30ipCgyUtB9d650zWQgNYmjE6
	1pEcFCc=
X-Received: by 2002:a05:7022:48f:b0:128:bae0:e044 with SMTP id
 a92af1059eb24-12ab28db6cfmr6100234c88.30.1774859455826; Mon, 30 Mar 2026
 01:30:55 -0700 (PDT)
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
 <CAGSu4WOLGADT4Z+iEw33K1M-1F1Pgu0aHBwk_8R_2tbee6k5+w@mail.gmail.com>
In-Reply-To: <CAGSu4WOLGADT4Z+iEw33K1M-1F1Pgu0aHBwk_8R_2tbee6k5+w@mail.gmail.com>
From: Deepak Pathik <deepakpathik2005@gmail.com>
Date: Mon, 30 Mar 2026 14:00:44 +0530
X-Gm-Features: AQROBzDMw-gwMaPkX2mxMWqVm_bHYTT1noMnTc7btaZkEoFomnd3yioTJf-qvXI
Message-ID: <CAHf8aCV+d0-YL8Gt_Xhw0knS7gz8FZB_RF315XOLtfOi4ec0Vg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC_2026=5D_Multi=2Dthreaded_decompression_for_fsc?=
	=?UTF-8?Q?k=2Eerofs_=E2=80=94_design_question_on_z=5Ferofs=5Fdecompress=28=29_parallel?=
	=?UTF-8?Q?ism?=
To: Utkal Singh <singhutkal015@gmail.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000640f89064e39ab71"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3110-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 919633572E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000640f89064e39ab71
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Utkal,

Thanks again for the detailed explanation and for pointing me to the RFC =
=E2=80=94
it really helped clarify the bigger picture.

I spent some time going through the relevant parts of the code and your
comments made a lot more sense in that context. I see now that while
pcluster-level parallelism is valid, the main challenge is making the
surrounding infrastructure safe before introducing concurrency.

In particular, I hadn=E2=80=99t fully accounted for:

   -

   the lseek() + read() pattern in erofs_read_one_data() and why switching
   to pread() is necessary for correctness,
   -

   the lack of synchronization in erofs_iget()/erofs_iput(), which could
   lead to refcount races,
   -

   and the implications of using an unbounded workqueue on large images.

Your point about backpressure was especially helpful =E2=80=94 I=E2=80=99m =
now considering
a bounded queue or a semaphore-based approach to ensure the producer
doesn=E2=80=99t get too far ahead of the workers.

I also revisited the design with this in mind, and the two-phase model
(serial traversal + parallel data verification/extraction) makes a lot more
sense now, especially for isolating shared state like fsckcfg and path
handling.

I=E2=80=99ll continue refining the proposal with these constraints in mind =
and go
deeper into io.c, inode.c, and workqueue.c to make sure the design is
correct before thinking about actual parallel execution.

Thanks again for taking the time to explain this =E2=80=94 it was very help=
ful.

Regards,
Deepak Pathik

On Mon, Mar 30, 2026 at 1:50=E2=80=AFAM Utkal Singh <singhutkal015@gmail.co=
m> wrote:

> On Sun, Mar 29, 2026 at 6:47 PM, Deepak Pathik wrote:
> > for LZMA-compressed images, are pclusters in fsck.erofs always
> > fixed-size and independently decompressible at the userspace level,
> > or are there cases where a pcluster depends on the state left by a
> > previous one?
>
> Hi Deepak,
>
> To answer your LZMA question: yes, each pcluster is independently
> decompressible by design. You can verify this directly in
> lib/decompress.c =E2=80=94 z_erofs_decompress_lzma() calls lzma_stream_de=
coder()
> and lzma_end() within a single invocation, with no persistent lzma_stream
> across calls. The same holds for ZSTD and deflate. The on-disk format
> enforces this: no pcluster depends on decompressor state from a
> previous one.
>
> The parallelism boundary you identified is correct. The deeper issue
> is one level up: erofs_check_inode() is called sequentially in the
> dispatch loop in fsck/main.c, and each call may decompress many
> pclusters per inode. Inode-level dispatch is simpler than
> pcluster-level because it avoids output ordering constraints.
>
> One thing worth thinking through before wiring erofs_workqueue into
> the fsck path: the existing queue in lib/workqueue.c is an unbounded
> producer queue built for mkfs compression workloads. On a 34,000+
> inode image, it will accumulate all inode descriptors in memory before
> workers can drain it. Backpressure =E2=80=94 either a bounded queue or a
> semaphore on the existing one =E2=80=94 matters here.
>
> Two paths in the surrounding infrastructure also need fixing before
> concurrent dispatch is correct:
>
>   - erofs_read_one_data() in lib/io.c: lseek()+read() on a shared fd
>     is a TOCTOU race under concurrent calls. pread(2) fixes it cleanly.
>
>   - erofs_iget()/erofs_iput() in lib/inode.c: ref-count mutations
>     without synchronisation. Concurrent iput() can double-free.
>
> I sent an RFC on March 22 covering this design if it is useful context:
>
>
> https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K61xoUCi3FB9QR081fNh-1ho=
X1z2TZMk0nGpHQ@mail.gmail.com/
>
> Happy to discuss further on the list.
>
> Regards,
> Utkal Singh
>
>
> On Sun, 29 Mar 2026 at 18:47, Deepak Pathik <deepakpathik2005@gmail.com>
> wrote:
> >
> > Hi,
> >
> > I'm Deepak Pathik, a second-year B.Tech student applying for the GSoC
> 2026 project on multi-threaded decompression support in fsck.erofs.
> >
> > While reading through the source, I traced the decompression path in
> erofs_verify_inode_data() and noticed that z_erofs_decompress() operates =
on
> a locally scoped struct z_erofs_decompress_req with its own input and
> output buffers =E2=80=94 no shared mutable state between calls. My plan i=
s to wire
> the existing erofs_workqueue (already used in lib/compress.c for
> mkfs.erofs) into the fsck extraction path at the pcluster level, with
> pwrite() for position-based output writes to avoid ordering locks.
> >
> > One thing I wanted to confirm before finalizing my proposal: for
> LZMA-compressed images, are pclusters in fsck.erofs always fixed-size and
> independently decompressible at the userspace level, or are there cases
> where a pcluster depends on the state left by a previous one? I want to
> make sure I'm not understating the LZMA case in my design.
> >
> > I've drafted a proposal and would be happy to share it for early
> feedback if that's useful.
> >
> > Thanks,
> > Deepak Pathik
> > https://github.com/deepakpathik
> > deepakpathik2005@gmail.com
>

--000000000000640f89064e39ab71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Utkal,</p><p>Thanks again for the detailed explanati=
on and for pointing me to the RFC =E2=80=94 it really helped clarify the bi=
gger picture.</p><p>I spent some time going through the relevant parts of t=
he code and your comments made a lot more sense in that context. I see now =
that while pcluster-level parallelism is valid, the main challenge is makin=
g the surrounding infrastructure safe before introducing concurrency.</p><p=
>In particular, I hadn=E2=80=99t fully accounted for:</p><ul><li><p>the lse=
ek() + read() pattern in erofs_read_one_data() and why switching to pread()=
 is necessary for correctness,</p></li><li><p>the lack of synchronization i=
n erofs_iget()/erofs_iput(), which could lead to refcount races,</p></li><l=
i><p>and the implications of using an unbounded workqueue on large images.<=
/p></li></ul><p>Your point about backpressure was especially helpful =E2=80=
=94 I=E2=80=99m now considering a bounded queue or a semaphore-based approa=
ch to ensure the producer doesn=E2=80=99t get too far ahead of the workers.=
</p><p>I also revisited the design with this in mind, and the two-phase mod=
el (serial traversal + parallel data verification/extraction) makes a lot m=
ore sense now, especially for isolating shared state like fsckcfg and path =
handling.</p><p>I=E2=80=99ll continue refining the proposal with these cons=
traints in mind and go deeper into io.c, inode.c, and workqueue.c to make s=
ure the design is correct before thinking about actual parallel execution.<=
/p><p>Thanks again for taking the time to explain this =E2=80=94 it was ver=
y helpful.</p><p>Regards,<br>Deepak Pathik</p></div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon,=
 Mar 30, 2026 at 1:50=E2=80=AFAM Utkal Singh &lt;<a href=3D"mailto:singhutk=
al015@gmail.com">singhutkal015@gmail.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Sun, Mar 29, 2026 at 6:47 PM, De=
epak Pathik wrote:<br>
&gt; for LZMA-compressed images, are pclusters in fsck.erofs always<br>
&gt; fixed-size and independently decompressible at the userspace level,<br=
>
&gt; or are there cases where a pcluster depends on the state left by a<br>
&gt; previous one?<br>
<br>
Hi Deepak,<br>
<br>
To answer your LZMA question: yes, each pcluster is independently<br>
decompressible by design. You can verify this directly in<br>
lib/decompress.c =E2=80=94 z_erofs_decompress_lzma() calls lzma_stream_deco=
der()<br>
and lzma_end() within a single invocation, with no persistent lzma_stream<b=
r>
across calls. The same holds for ZSTD and deflate. The on-disk format<br>
enforces this: no pcluster depends on decompressor state from a<br>
previous one.<br>
<br>
The parallelism boundary you identified is correct. The deeper issue<br>
is one level up: erofs_check_inode() is called sequentially in the<br>
dispatch loop in fsck/main.c, and each call may decompress many<br>
pclusters per inode. Inode-level dispatch is simpler than<br>
pcluster-level because it avoids output ordering constraints.<br>
<br>
One thing worth thinking through before wiring erofs_workqueue into<br>
the fsck path: the existing queue in lib/workqueue.c is an unbounded<br>
producer queue built for mkfs compression workloads. On a 34,000+<br>
inode image, it will accumulate all inode descriptors in memory before<br>
workers can drain it. Backpressure =E2=80=94 either a bounded queue or a<br=
>
semaphore on the existing one =E2=80=94 matters here.<br>
<br>
Two paths in the surrounding infrastructure also need fixing before<br>
concurrent dispatch is correct:<br>
<br>
=C2=A0 - erofs_read_one_data() in lib/io.c: lseek()+read() on a shared fd<b=
r>
=C2=A0 =C2=A0 is a TOCTOU race under concurrent calls. pread(2) fixes it cl=
eanly.<br>
<br>
=C2=A0 - erofs_iget()/erofs_iput() in lib/inode.c: ref-count mutations<br>
=C2=A0 =C2=A0 without synchronisation. Concurrent iput() can double-free.<b=
r>
<br>
I sent an RFC on March 22 covering this design if it is useful context:<br>
<br>
=C2=A0 <a href=3D"https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K61xoUCi=
3FB9QR081fNh-1hoX1z2TZMk0nGpHQ@mail.gmail.com/" rel=3D"noreferrer" target=
=3D"_blank">https://lore.kernel.org/linux-erofs/CAGSu4WNBdB30K61xoUCi3FB9QR=
081fNh-1hoX1z2TZMk0nGpHQ@mail.gmail.com/</a><br>
<br>
Happy to discuss further on the list.<br>
<br>
Regards,<br>
Utkal Singh<br>
<br>
<br>
On Sun, 29 Mar 2026 at 18:47, Deepak Pathik &lt;<a href=3D"mailto:deepakpat=
hik2005@gmail.com" target=3D"_blank">deepakpathik2005@gmail.com</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; I&#39;m Deepak Pathik, a second-year B.Tech student applying for the G=
SoC 2026 project on multi-threaded decompression support in fsck.erofs.<br>
&gt;<br>
&gt; While reading through the source, I traced the decompression path in e=
rofs_verify_inode_data() and noticed that z_erofs_decompress() operates on =
a locally scoped struct z_erofs_decompress_req with its own input and outpu=
t buffers =E2=80=94 no shared mutable state between calls. My plan is to wi=
re the existing erofs_workqueue (already used in lib/compress.c for mkfs.er=
ofs) into the fsck extraction path at the pcluster level, with pwrite() for=
 position-based output writes to avoid ordering locks.<br>
&gt;<br>
&gt; One thing I wanted to confirm before finalizing my proposal: for LZMA-=
compressed images, are pclusters in fsck.erofs always fixed-size and indepe=
ndently decompressible at the userspace level, or are there cases where a p=
cluster depends on the state left by a previous one? I want to make sure I&=
#39;m not understating the LZMA case in my design.<br>
&gt;<br>
&gt; I&#39;ve drafted a proposal and would be happy to share it for early f=
eedback if that&#39;s useful.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Deepak Pathik<br>
&gt; <a href=3D"https://github.com/deepakpathik" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/deepakpathik</a><br>
&gt; <a href=3D"mailto:deepakpathik2005@gmail.com" target=3D"_blank">deepak=
pathik2005@gmail.com</a><br>
</blockquote></div>

--000000000000640f89064e39ab71--

