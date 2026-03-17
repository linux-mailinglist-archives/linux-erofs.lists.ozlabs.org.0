Return-Path: <linux-erofs+bounces-2783-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD5vHh0CuWmJnAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2783-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 08:26:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4E42A4C2A
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 08:26:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZk6067Ncz2yh4;
	Tue, 17 Mar 2026 18:26:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773732376;
	cv=pass; b=GqsEqwQ/UajIBT0eatyZyb/E4C4TasGCMVlXbU3tpmggGs7EVQ6sZddIWFE7s9LS1Eg657wCj+uhB7vBJ/WrE+KKikiwIUKSBZRzwKk9kdAwBL25Z32QkQ8alz6kv+J5tJoHpeEzVHu3AP2F8JkzhNjxHUOjtwhuJvm5L14FAkX7Shlz8ozbo3sfpArbCL1CKHD3FcaAJVj2VD/43Muhe2S7td4ix84Tqv94Stl67sL6H7wl4yNQalZHgQNl5wgtrgeeBXP10S5xnya/tEsvpeJm0LEhT1QxAecT26eIJvOC1CXPauhet1qJO8y6qvPuEIYq+q1fBNVFtmTrUJbgsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773732376; c=relaxed/relaxed;
	bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqwy/cW1t6zjWQl2/OwvT9n4FykIoEtFcHAXG4h8l1qYePILVZtsQD/nljvgdEHuMDyscyFi1Ng8DZxqkQ8mWEPiWt8d7aXkDh/EkPdBt5KQu0kc2nUQmqN1ODLQc+doc+XTMe8KEvXW5HAA95emZg6rHfDKlzsvwwC+N9argUzAvVB/PZdHC7ZVU15cQkeNqeEhpuaet2Q17FG4m30mpMsdcQ5P+cLBY3UwJnmf4pkTwV6nmPbHi4dksgKHuq5c0goY/7Vqr0IkdzKfmjvfdVICNXkwTECqjO0JIkggadIo436wgNnMKLk45iIxJt/IRs71Bt0ZwpGFkISjuHKO/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X0GfoNKO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X0GfoNKO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZk5z5XPYz2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 18:26:14 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b9789425fc5so62962766b.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 00:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773732372; cv=none;
        d=google.com; s=arc-20240605;
        b=Pmc25BSMSUpy2BvZj/soqWedBxM96ZBnobcfVTwAKZfn/R2GWhdjHSmLmdFa8WyQ3e
         FIJV2DIfjYQT7z0TVqM3FhvoBdQuvOvCX0UdxryJqeUOA+yzpXcrT1Fb33FB1oMiW+yY
         9SId8BXDJ7iDP6uwbdNYjfIl/1mFAC2CKDvZ1/YYz48sYLDhqV8lfPRRK5ka5Zmgrtar
         xmNXch4eHVnO+ujL8BDWIj+2PpgTZDo9W5LAfWJGsvyvl2q0/NWZXcH7N0UvmscHWDnd
         PdOEtDrWHqObFOwo9PCgreh56npxKil+i4OfVXWPvz0FxSsrbQ+hxd3nFGqALwznflYR
         KABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        fh=BuECZ1gVE0ToshHwBIL9alEMnV5AMbYbvZEzuOwdVCQ=;
        b=SqK5e6W57YR3HPWaVvHBMDjUWk3x3ww9HVFNkr5MndQpZI/wJdCqvTWRhqfOt28Uwh
         3g9Khrbe/dLru9XZOa8m27uuBseyEBP68szWeoD0h9RmYBCoLwum95Z7oQS76BUeqlBL
         xVAfvcmUTZkzCljiTCfRU10QQm37PLj7NPIfy3BlXLUIBJtvH9d7wZY7fBulMJRUfRhR
         XyG34Un7trfY3R55AbTdPJxxAqnZWa6cLUNjdnhtJG14UuPXDvSW7aJzg+CD3rZkzU9a
         cN9UpYDb6O67irFw+WlfDUIJPYJDRpw/j2r9y4FXwYnZcUDycq5Cbs/sLMt3kYjGLfgY
         PCHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773732372; x=1774337172; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        b=X0GfoNKOaYPPyaz1bYLBNTGLJQZLICzgq4q6s3YzClyke+t3hgm72p37pdtC2sbM5a
         yc+Cv4CyQ+NpHajKNv8FSJ5xkGwpK6ZqHixp9GZv8uVLUqDgTCpspDinOG//l0OfeLKf
         +twueRirnHDn4peHn3Gxs2X39963FoXsKTb4NaHrMkMCxTFvSsExMy021Wb0Z5stMODF
         yKJrqeZ/FX4xYnyzITqajY55j+ODfj+k236jj6kIipjLBJFTpynzQFHyLHbN8g6KIukJ
         SBxxb0BgNVzx7SYQCxZ4gnnl/qcPgngBmgnWPm89rKOC34GmdhK/H+57cnxubGwU0wZt
         UMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773732372; x=1774337172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        b=sYp3CVDXl6mRGHRGFTOkmMejO2eiVUfYWXKl7tP5YMHCIjJxcHFCCwohLu0D3NyUGo
         d5kBlhG4+z5vF+xFhPzSZyjGBG/hEWiog55KNNcnG/oeABGL83YaJ9EFLx1aE/3558Rn
         S+yeeFR4AGTWQCcTj44e3iE/R+Jh5fDYgOQZML6gCg1pgdWyrPGThMNoLIljwH3xE76L
         qh8TzeUux9rZIBPRKH8TxAQXiPu0nRQFYp34JFqP5N/4UPCvAQBa9J4AMoMAJUGxBvjJ
         KghvASgjEIM69JaqRnxbl+p5YwlUZffq79ZZD5xMTc7yaQP3n9R4HrKV1joalRxmEE87
         OdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKzHX8ZHW1ST6qYwMO50lGUSicxd19osWEYoQ3UaDGohcIXj6l3HmpWB2+x92HCTQU7o387rKtzVtvFQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9/8AlV+CRfwoTGaf9prwwhyWjQZRXQCDATudhybK63Q1RYSLV
	S/D3LL3yaHUhLj8ozy3pO/rtVzq6gfaiJ9QR8/rIt0ONw90oKoInU96BUhVtjVYdHadpNY1JKUU
	RtbxzCTeVYrsbUWHMvCq0o7mCWiu0AzQ=
X-Gm-Gg: ATEYQzxo0XlpxZdF0ySuCmhgYJv38mMJW4wlWyE+JbFkEvXD1h6St3jMpRd7159lRUq
	RdPDSoqjiCqsAduYXiTIr3fUUIHtPJroQ7TfvLfsa2BXw37K3qmbClNR5ZyuiNolhhEaLbAJc7o
	n1I5Mmehom3i2Ab9gXRBU/IqTxRQRDQMhxKL9bK+avTZm8+GbkdWS0rozy8ouMOUoSx5xhxgQzy
	d5DPOIPaVsXOm6EIgETIC199jvMmxPaur5id8boRLFTrCKIUFLP3PCJ7i9KbNRw/qda7VHiTOOs
	88U17YcG/Ac05Spiyn06KqDMxbrqFSgIflnc9IE8
X-Received: by 2002:a17:907:3d03:b0:b94:231f:26ca with SMTP id
 a640c23a62f3a-b97d6d99d0fmr133734066b.20.1773732371166; Tue, 17 Mar 2026
 00:26:11 -0700 (PDT)
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
References: <20260316213606.374109-5-paul@paul-moore.com> <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
In-Reply-To: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Mar 2026 08:25:58 +0100
X-Gm-Features: AaiRm50sF1v33VMxCQO8F4CAvv3PlKmjLZTCcf_1PYwrrTaEu5VQoATkjlrFBkw
Message-ID: <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2783-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8C4E42A4C2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 10:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing mmap() and mprotect() LSM access control points for the
> > overlayfs filesystem are incomplete in that they do not cover both the
> > user and backing files.  This patchset corrects this through the additi=
on
> > of a new backing file specific LSM hook, security_mmap_backing_file(),
> > a new user path file associated with a backing file that can be used by
> > LSMs in the security_file_mprotect() code path, and the associated
> > SELinux code changes.
> >
> > The security_mmap_backing_file() hook is intended to allow LSMs to appl=
y
> > access controls on mmap() operations accessing a backing file, similar =
to
> > the security_mmap_file() for user files.  Due to the details around the
> > accesses and the desire to distinguish between the two types of accesse=
s,
> > a new LSM hook was needed.  More information on this new hook can be
> > found in the associated patch.
> >
> > The new user path file replaces the existing user path stored in the
> > backing file.  This change was necessary to support LSM based access
> > controls in the mprotect() code path where only one file is accessible
> > via the vma->vm_file field.  Unfortunately, storing a reference to the
> > user file inside the backing file does not work due to the cyclic
> > ref counting so a stand-in was necessary, the new user O_PATH file.
> > This new O_PATH file is intended to be representative of the original
> > user file and can be used by LSMs to make access control decisions base=
d
> > on both the backing and user files.
> >
> > The SELinux changes in this patchset involve making use of the new
> > security_mmap_backing_file() hook and updating the existing mprotect()
> > access controls to take into account both the backing and user files.
> > These changes preserve the existing SELinux approach of allowing access
> > on overlayfs files if the current task has the necessary rights to the
> > user file and the mounting process has the necessary rights to the
> > underlying backing file.
> >
> > --
> > Amir Goldstein (1):
> >       backing_file: store user_path_file
> >
> > Paul Moore (2):
> >       lsm: add the security_mmap_backing_file() hook
> >       selinux: fix overlayfs mmap() and mprotect() access checks
> >
> >  fs/backing-file.c             |   28 +++++---
> >  fs/erofs/ishare.c             |   12 ++-
> >  fs/file_table.c               |   53 +++++++++++++---
> >  fs/fuse/passthrough.c         |    3
> >  fs/internal.h                 |    5 -
> >  fs/overlayfs/dir.c            |    3
> >  fs/overlayfs/file.c           |    1
> >  include/linux/backing-file.h  |   29 ++++++++-
> >  include/linux/file_ref.h      |   10 ---
> >  include/linux/lsm_audit.h     |    2
> >  include/linux/lsm_hook_defs.h |    2
> >  include/linux/security.h      |   10 +++
> >  security/security.c           |   25 +++++++
> >  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++-----=
-
> >  14 files changed, 231 insertions(+), 60 deletions(-)
>
> Due to the nature of the issue, I'm going to merge this into
> lsm/stable-7.0 in a few moments so the changes can get some testing in
> linux-next with the idea of sending this up to Linus' later in the
> week.  If anyone has any concerns over this patchset, please let me
> know as soon as possible.
>

Since previous 4 revisions were not posted to public list,
let me repeat my concern from v4:

On Fri, Mar 6, 2026 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Mar 6, 2026 at 3:24=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
...
> > My expectation is that the merge of this patch will be collaborated
> > with Christian ...
>
> Of course, that is one reason he is on the To/CC line.  More on this
> in my reply to your 0/4 comments.
>

I am sorry Paul. This must be a misunderstanding.

My expectation for collaborating the merge of my patch with
Christian was that an agreement would be reached regarding
which way it would be routed to Linus.

CC to Christian and sending the patch to Linus without getting any
ACK from Christian was not the way I expected this to go.

> > and that it will NOT be auto selected or rushed into stable.
>
> I haven't marked it with a 'Fixes:' tag or a stable Cc which in my
> experience are the two quickest ways to get pulled into a stable tree.
> I'm not sure what stable policy Al or Christian have for the VFS tree,
> but LSM and SELinux commits are not pulled into the stable trees
> unless explicitly marked with a stable Cc or requested by a dev after
> the fact.
>
> > I don't mind if you want to route the security_mmap_backing_file() hook=
s to
> > stable to use it for some simpler bandaid for stable, but rushing this
> > one to stable is not a good idea IMO.
>
> Once again, see my (upcoming) reply to your 0/4 comments.
>

TBH, I don't understand the logic of placing patches in lsm/stable-7.0
without the intent of backporting them to stable.

I perceive my patch as a risky patch for overlayfs and the vfs
this is why I wanted Christian do be part of the decision if and when
my patch is sent to Linus.

Thanks,
Amir.

