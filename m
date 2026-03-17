Return-Path: <linux-erofs+bounces-2814-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF/5E3WauWn5KwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2814-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 19:16:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54D2B0C53
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 19:16:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb0X13lj8z2yhV;
	Wed, 18 Mar 2026 05:16:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773771377;
	cv=pass; b=XYbX+Uvojw05Xdo2E/RNiHHi5/McawQzqJ3l1cHYuhLj0tHBFE/pzT4A7dwC/y0fNIkABqhMfJbIXJlbiXs31Couw6Gwa6qqLDnEXYqwHFsadlmwenMGTI4NKuB2Gwuiq7zMXoOxwcVx9wwDHJIKvIyV9MQMRzStIl0K3nfaR7+9gTBm1zPiRQ0WtkUFf7eL0Ugjc8p9mV5n3mO/prQQhL+SyQyGUze4hyL0NBEZghiDp4rEvs5hoAyRC4nvAiUCOIx0Mu8ssHPQpZjkod5+iiVKTlgDVkpH3oWNn90PateRW831f2S0qUZ+ScjC+7fF4pknSHzbRWuw07E4N5gJ4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773771377; c=relaxed/relaxed;
	bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgCn3VmENFPiAkk+eFzfnzYz+iZgzpFHKIEXJ+PgBymEBzFICuIWQLWbnLKgYEExe0YYr7eg4lbUl1HruWh2KZfrju32urbf/LH9J4maCUGEO3M9OEd+jx2eu0URmEgOlNVEO90aT64DTkARG2yisHF/nygvUJU5nibKpbza97di0YaIQgsixPMxw8ZlnCQdFeRnsS1POxMs+scOBuLTPl3vMLUUt45SHMq16R94BA6OxZDbuoIGy+8uP7pU4QxJniaUGgnu4k+nbKCTt26KLYeUTy6teaiJCcZ8QLqI7oT007ZXvCOkT8BQCYxqr7yqg9f/DBj/DHEgja06Jv0g4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OXWxVqHH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OXWxVqHH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb0Wz66YSz2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 05:16:14 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ab077e3f32so27988715ad.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 11:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773771373; cv=none;
        d=google.com; s=arc-20240605;
        b=QkBz1Yx5qjgmd3EuKCmwdp/vTbON2sOKnZhkmq/Ax1jHRvpoSAv4sFqMGidEDIEMMY
         7eX1ejObkO/U9st8ycDiKO8zkyqF/ydphUWTxV2P4gkFnho+cXo3eKVhsSmXNBwNZc/P
         aDXMqka7aO4Cv/RlEtyWEacJL+iiMafRMZQvj/4p2DTvSE/tRgCM9A2//QjTl+3eoxFh
         BUmNvmRoC9/uvu0GSf4Wj9eskFGde4aE66upuhJnU+CJ+GldspMyMEvDujH6KT+jghLv
         ucfaLUS0T+SEelv8Ec3sWyFui5XheMXIY6Hl3BtGISysNEbjvk93SbXGkgJCjImnoOKV
         heUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
        fh=MKVjo/2ABjeozwiKU5BVKZc3pXvleXbZMT2EbLkx/t8=;
        b=j/PrsCscSb/zAy+2/fisdGXFnZsB7jGMP8ViFG5ZkultQOx0g370EeGCzdg+5nNkTM
         LQtXUTn/46dOldC4kFG7s6DQI9daQfeG1fQw7yt6h0r/7CtgOhpzNEsRMexp2bWQG+Gf
         AVueiILbwtL/hvvsZGucbf/daRtw6ZXNS9R9CRKG+m5cQpMx/ZylEBJ2Ke1Gq9wgT7PY
         4xmKiTJPZcY6LKn18/Y1RHZ1f8AcioK6B5RIeysmc8nK3mKluo2nVBq+TzBy5GYx21Nq
         eg3HQxFzGncR/XnCnUIZo+/o11aR/8bOyvvvBwWB0HTTPsZ/jDlTq1KJE2+TEvuhamqv
         D89A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773771373; x=1774376173; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
        b=OXWxVqHHTp6bbtMGg+Mv0RGNfTelzj0ve6nOIpDiTqOi/okEaWxWKHeLNeFKri2TBf
         E/qnIgQuloHiUyEBEqsDO/fco7DErLkVaTlhKwoiwTu6dxAGmW94YMssA2oo97DFWJe5
         lri1zw0uQO61nF46tnNVkaqZ23EotrJx/zTj11rjjjlD+luDSDZXF32C4lvt6aGBtX8k
         jzochcU606NI/yBpK+WQ9P542EnjOcmgexsXd977VmliFsvOYtfXVR2uC2gXpqt334UK
         0yOIAtNgM9kyETFxBofn45aiEHyIugfv7dl6CbjJ+CfNtsbRoeNWCZEJv0okquXEG7AY
         e2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773771373; x=1774376173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WngwhPK+4r0TmrjPdHGSTFw/2nCwtZ82oV0G4lyV188=;
        b=rf8M5fVjQ9SsYDHBwJJL4SRpuxlyxXEx+QJvYhKI90xMARkS1VbAfeZBEfaP43aA18
         dzMGoQSvJFEUqhnmta8tboRWKI6JIw5QLH5N4AqK87ZZQIyoxa9vMb6SZgpGnKJx85PH
         115HeDX0htcPK5Xx6DA5dh+PjkXQq/izExxUpPMGVndwQC6Hn+c0DcLCkQILcqKJxCQa
         LFecKmeFpwZPVSTHlFqCtxJV4+/lHzjafxorh1kJIFHQe1PFAJ07kejHG8JJjMyUNHBy
         j/OPWUsmtNzUTeve/jMTa3YaqFam5oegZhdS0fTI20whKHv7/aBwNYpVNdpjazQ5TtQt
         6gbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHfGFn2XInj66KebO+EOI5O6ZciRxzDGHwhPexv5NI7LbxhhA4THIVU89KravI0yK6Zq0BDBgLhB73xA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymLELA3lghWai5kTqW7OQOntjkpPfXjGytyk6yMF96yuSVCM/M
	SZvPytGzO6EpxIFSyplXmgV1b/XAhjp4bbbrANI8Ab8a17itHiPpttK+oeOFHFL4qU2TYs8/D4Z
	dt8GdHpBrrqIjfXBPadgBdFZj6GcV6LxPn8j/gl+D
X-Gm-Gg: ATEYQzxov1esL03RiSxreJX29x6RHY7TFIddVnL39CBMtXBYwScdmnuKZ2WQur9XyI3
	nIlbsFi8JpQMh8kpruBUCR+zVEmOOhuG+sqPD802au8R4JjgD/in5O5jKyv+Rn2Wb4QbyppUQ0K
	7NWzzdYyN4CH4BStWQFCLyzPhaj1GDb9Vsvm2L7FF5vDeJDtaa0vmrkgbIBbQv8ImWJhlFyglxw
	4fls585ZS1kT517WPubEcLJN9aWv5lpA7xglYVCPelklykIphSsJbPfU67chasfX/BsuX3UpdtL
	KeLP2PY=
X-Received: by 2002:a17:903:1447:b0:2ae:c5fc:b2ea with SMTP id
 d9443c01a7336-2b06e3d2eb0mr4770225ad.30.1773771372739; Tue, 17 Mar 2026
 11:16:12 -0700 (PDT)
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
 <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
In-Reply-To: <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 14:16:01 -0400
X-Gm-Features: AaiRm52ZqNJHAbRzZUAvcxik2J2qc91q1AUn-hHxOheIit1e-BlWZgjcVmBec3Q
Message-ID: <CAHC9VhQX4aDvrd9uX1ESGteWpLLGbXmH1+SVFfE06juAsSCkGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2814-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2D54D2B0C53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 3:26=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Mon, Mar 16, 2026 at 10:59=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:

...

> > Due to the nature of the issue, I'm going to merge this into
> > lsm/stable-7.0 in a few moments so the changes can get some testing in
> > linux-next with the idea of sending this up to Linus' later in the
> > week.  If anyone has any concerns over this patchset, please let me
> > know as soon as possible.
>
> Since previous 4 revisions were not posted to public list,
> let me repeat my concern from v4:
>
> On Fri, Mar 6, 2026 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Mar 6, 2026 at 3:24=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> ...
> > > My expectation is that the merge of this patch will be collaborated
> > > with Christian ...
> >
> > Of course, that is one reason he is on the To/CC line.  More on this
> > in my reply to your 0/4 comments.
> >
>
> I am sorry Paul. This must be a misunderstanding.
>
> My expectation for collaborating the merge of my patch with
> Christian was that an agreement would be reached regarding
> which way it would be routed to Linus.
>
> CC to Christian and sending the patch to Linus without getting any
> ACK from Christian was not the way I expected this to go.

To be honest I expected Christian to provide an ACK by now, as he
reviewed and commented on your earlier patches with the O_PATH file
approach.  He has had weeks, if not months, to comment further and/or
supply an ACK so at this point I'm proceeding ahead as I mentioned to
you (and Christian last week).  You were very anxious to bring these
patches on-list, which I did, however, now that everything is on-list
there is a responsibility to act on this quickly (this was the
motivation for discussing the solution privately at first).

Hopefully Christian will comment, and preferably ACK your patch, but
even if he does not we still need to go ahead and fix this soon in
Linus' tree.

> > > and that it will NOT be auto selected or rushed into stable.
> >
> > I haven't marked it with a 'Fixes:' tag or a stable Cc which in my
> > experience are the two quickest ways to get pulled into a stable tree.
> > I'm not sure what stable policy Al or Christian have for the VFS tree,
> > but LSM and SELinux commits are not pulled into the stable trees
> > unless explicitly marked with a stable Cc or requested by a dev after
> > the fact.
> >
> > > I don't mind if you want to route the security_mmap_backing_file() ho=
oks to
> > > stable to use it for some simpler bandaid for stable, but rushing thi=
s
> > > one to stable is not a good idea IMO.
> >
> > Once again, see my (upcoming) reply to your 0/4 comments.
>
> TBH, I don't understand the logic of placing patches in lsm/stable-7.0
> without the intent of backporting them to stable.

I'm not going to copy-n-paste my previous off-list reply, as I have a
rather strict policy about forwarding private or off-list emails to a
public list without consent.  However, the quick answer is that
inclusion in a lsm/stable-X.Y branch does not mean a patch(set) is
automatically tagged for stable, in fact you'll notice none of the
patches have a stable marking, mostly due to your previous request.
As the LSM and SELinux trees are not pulled into the stables trees
unless explicitly marked, or requested, I do not expect those patches
to be automatically backported.  I do not know the stable backport
policy for VFS patches.

> I perceive my patch as a risky patch for overlayfs and the vfs
> this is why I wanted Christian do be part of the decision if and when
> my patch is sent to Linus.

Christian has been a part of the discussion for months now, and has
already provided feedback on the VFS portions of this patchset (which
you have incorporated).  I agree, I would appreciate it if Christian
could supply his ACK, or an alternate solution, but as you strongly
encouraged us to bring this issue on-list, we now need to get a fix in
Linus' tree soon.

--=20
paul-moore.com

