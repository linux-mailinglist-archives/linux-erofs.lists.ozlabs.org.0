Return-Path: <linux-erofs+bounces-1810-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8510D0D505
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Jan 2026 11:50:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dpFlS0fydz2y8c;
	Sat, 10 Jan 2026 21:49:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768042196;
	cv=none; b=Bt/1MgvVHVxd04OLuiiCFouuss1yTPACLD7W0gyx4lWf+J9oIdG1dqwBXt90HY1MsMSNC8XxKufFRcIOeIhE+4zf6fOdcMdSztnbMUjFCxk35gHh+tMupekIQnTMkFGwl7ajVmxSNg0DLtJLQg2CS4XQ0OzmyA6Ta8zvvMc8luPxibBT74So2n4dQY6KDmsvmK62iLKmPBtVJWla1DyKbeBoh1xrodYd4gWSprwIb6XtjkF2XZjRHhryzvIM6vM5pqj1/fOTC2QAjNRyoudSOI6MFRLGiaOO0DOPN9zAsqVPk4e3X5LHauzXR9LYCS3WHHyoVMDddOQUiwtQWnlx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768042196; c=relaxed/relaxed;
	bh=WLlwj2SRurXL9N+OiPWYrAC63WN/ZG5ygPYKRd+jJhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEoYKVSPkNNHbGD27ivlGuVXeEKqtpypk7874x0xOkYs9NhgUrH0g5thzsUTnxUqdnMDVsMBKxj661OaAaeqNewlDHRPflLmhT3n2V7Dm2MlVHDnamWk8sY4IOtiGeOpLi7P3LukPNIiiOayIoHWZcp8S4U5DhHblMmQ1U3xeKIMk/ru+6jtoIyW3RadpAHf+RwhziYCaOB8Kh3Gyx5xPT9p565aji5zR9AXCxSKLJL+oUUCA6/Dyc7vcR/Uz4RP0yEC54fuBTtfbkhHaN4+XZUJBy1wGh4wAPbx38QVNNCgvfyyJqjtvQDjzxiFAXmOAY1ybcdHpC+puRXXTKJiYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EedeyxD3; dkim-atps=neutral; spf=pass (client-ip=209.85.218.43; helo=mail-ej1-f43.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EedeyxD3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.218.43; helo=mail-ej1-f43.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dpFlQ5WS3z2xRv
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 21:49:53 +1100 (AEDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7eff205947so713344966b.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 10 Jan 2026 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768042130; x=1768646930; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLlwj2SRurXL9N+OiPWYrAC63WN/ZG5ygPYKRd+jJhA=;
        b=EedeyxD38jNiloTByLM/MnEX6rNRuhAj3Px95nLU7yZrrzLgLHOHlUbezL5EpXImEq
         Vi1A+stgUvYq94QVXTcqi+QADgufdVCkUqdT8XRyhwSQHlSKgigLqI5UTNjYxuiREJme
         3Ckf5k869zqH0HPBu5O3G3o4VZZMPCg+cNypNEAEZ/Bp0PqbW1H7E6iiThQWkrbIDepm
         zCVPBUEi04Us2Ss+F91qO78dVAIvXZHrFDN7xFhWezNqVPyGhmIqLNb8DYDxS4eqgkr7
         mU1swfrjcYPQi3gYUzwSg2bPWhQhENbw2nYZnviAoqbwvdRvu16XwN/kMjs/0cwr9Z1h
         yDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768042130; x=1768646930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLlwj2SRurXL9N+OiPWYrAC63WN/ZG5ygPYKRd+jJhA=;
        b=qeCqgN93OhDHwxE7vyV6I1x0N/rbpFqaxuXFiT7okxF3GNNrbFl3NWU+lLdP+ekNOY
         SM0oz8A/1YBp5AJb38B+ZtWeVlPZ3yI4YI6MrQw4Jnl5vxoXKMagPg3L5Y5eC5N52FKk
         aYV4r1yrmWRwI+8/GYwN9YUStR8o99TiiOxQ8KvhmXAOtCVuXCbOt/ymWhoOtd/ls1yR
         ZC6iqvC5mHp77DrUnitvq/TxtSLLgW1JMdN7r85GrQAecNPgEatHIHIDnDzQ2587KL/h
         cXbGftf76f2QUDrCgihYumT1dFMv05UROnZuUjIfO4yegkUs9F5dg4kYaRdzmnC/VdTc
         i3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ54zgbb9l0dgW2ZY9ldFhCI9NtIkY35kPVw2BcPntfD0JSQ369K+dGOf75sg0yrLRatrCVPxJ5m7g7A==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8A3c3O0vCF3BPeMCxXqEhTaJXZLDkcYBUk7degKdm4zZ+eal8
	mEBjGZpygz0K9P7uJebHZIUtj97OtjFOF2kDatKn8pA0zAl2Jezus4bjOUttXDsaUl0ctdr5OIS
	ka9KQp9IsIMWXlBjK5SzbvCWO4aMOdfg=
X-Gm-Gg: AY/fxX5Q7NIWbTpmQSw5GY4KbQopsS2cYPdaux7xibJG9XCOh421OXydmhhi9i2ujyy
	vf3ji7LPsPtAdV6B6gyTHssEqWsWmtznJpNudohdmw7lyriV3h5/elwWoaf2XdXRKoSN0rQNcaA
	B+X8cQSeBcsbeG6iXrm+O+Y9EipjiLV+WxEwzaKJRr8/sSELAlekZ4H7H7XaywRekO+N7Y5YpY+
	jqvA+JoE7NAmDQsua7IoHJqDYyD3zbcRWjFucCLAwi/lc3f034rxC13cMbwhqwDX8lyqxUL+GBg
	EYd4a92YYbQEh+/EBtowr1kDZh90b2WNkI3M3CY=
X-Google-Smtp-Source: AGHT+IH+xCaPfkvQPjnoFwM7Jrxt+4KBXGH3eFeltqIV57TI656jg9a9AxvhGgNkGnRu/9VXxKTkfU9gB3V2Vdtn/NE=
X-Received: by 2002:a17:907:969e:b0:b86:f999:15ba with SMTP id
 a640c23a62f3a-b86f9992708mr89993066b.18.1768042129662; Sat, 10 Jan 2026
 02:48:49 -0800 (PST)
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
References: <aWHibOkAT18Hc/G5@debian> <aWH/dP4xD51Rqwa+@debian>
 <CAOQ4uxht2EWvryy9bZw6uRsCyAc6WCHHvAjP=X92x9Pk9CaM0g@mail.gmail.com> <9303721e-5b67-4c66-8369-61c5125b1fb1@linux.alibaba.com>
In-Reply-To: <9303721e-5b67-4c66-8369-61c5125b1fb1@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 10 Jan 2026 11:48:38 +0100
X-Gm-Features: AZwV_Qjhid0fRcSBxzNkvZR71LIySyN9vQsBIjoejfpcorI2urfHK9chNLwjKNU
Message-ID: <CAOQ4uxi99wRKca1M-tvgb5SrhcuK=R_8q9nYRsf=CxLOTtU5Og@mail.gmail.com>
Subject: Re: [GIT PULL] erofs fix for 6.19-rc5 (fix the stupid mistake)
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, 
	LKML <linux-kernel@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, 
	Dusty Mabe <dusty@dustymabe.com>, Chao Yu <chao@kernel.org>, 
	Sheng Yong <shengyong1@xiaomi.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, Jan 10, 2026 at 11:30=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi Amir,
>
> On 2026/1/10 17:50, Amir Goldstein wrote:
> > On Sat, Jan 10, 2026 at 8:27=E2=80=AFAM Gao Xiang <xiang@kernel.org> wr=
ote:
> >>
> >> Hi Linus,
> >>
> >> Very sorry I sent an incorrect pull request which used an
> >> outdated PATCH version (I just manually applied tags on the
> >> incorrect version, but I didn't realize), I shouldn't make
> >> the stupid mistake in the beginning.
> >>
> >> Someone reminded me the mistake just now.
> >>
> >> Could you please apply this pull request, I promise that I
> >> won't make the similar fault again and I should be blamed.
> >>
> >> Thanks,
> >> Gao Xiang
> >>
> >> The following changes since commit 072a7c7cdbea4f91df854ee2bb216256cd6=
19f2a:
> >>
> >>    erofs: don't bother with s_stack_depth increasing for now (2026-01-=
10 13:01:15 +0800)
> >>
> >> are available in the Git repository at:
> >>
> >>    git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/=
erofs-for-6.19-rc5-fixes-2
> >>
> >> for you to fetch changes up to 0a7468a8de7a2721cc0cce30836726f2a3ac212=
0:
> >>
> >>    erofs: don't bother with s_stack_depth increasing for now [real fix=
] (2026-01-10 15:13:12 +0800)
> >>
> >> ----------------------------------------------------------------
> >> Changes since last update:
> >>
> >>   - Revert the incorrect outdated PATCH version
> >>
> >>   - Apply the correct fix of
> >>     "erofs: don't bother with s_stack_depth increasing for now"
> >>
> >> ----------------------------------------------------------------
> >> Gao Xiang (2):
> >>        Revert "erofs: don't bother with s_stack_depth increasing for n=
ow"
> >>        erofs: don't bother with s_stack_depth increasing for now [real=
 fix]
> >>
> >
> > Gao,
> >
> > You merged the wrong patch version by mistake - no real harm done.
>
> Sadly, the merged one doesn't work for Android APEX (Sheng actually
> claimed that PATCH v3 RESEND works instead of PATCH v3 [I'm very sorry
> for v3 RESEND mark again here] and it was him found that the merged
> pull request used wrong version and he gave me a private text hours
> ago), see my explanation below.
>

Yes. That's what I said.

> >
> > But now that it was merged, for the sake of git history, I think it wou=
ld
> > be better to merge a fix patch rather than revert + patch with same tit=
le.
>
> My concern would be that people could merge incomplete patch chain,
> but I'm fine to send a fix for the fix, I will do.
>

This is what the Fixes: tag is for.
Stable kernel maintainers know how to look for those when applying fixes.

> >
> > If you merge a fix patch you could properly attribute Report/Review/Tes=
ted-by
> > to Sheng Yong [1].
> >
> > It's true that the merged patch already claims to work for Android APEX=
,
> > but it had a braino bug and this is what fix patches are for.
>
> Sigh, the merged patch (PATCH v3) actually _breaks_ APEX (it's just
> like PATCH v1/v2), because:
>                 if (erofs_is_fileio_mode(sbi)) {
> -                       sb->s_stack_depth =3D
> -                               file_inode(sbi->dif0.file)->i_sb->s_stack=
_depth + 1;
> -                       if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPT=
H) {
> -                               erofs_err(sb, "maximum fs stacking depth =
exceeded");
> +                       inode =3D file_inode(sbi->dif0.file);
> +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops && !sb-=
>s_bdev) ||
>
> Here `!sb->s_bdev` is true for all file-backed mounts all the time,
> so `!sb->s_bdev` equals to a no-op.
>
> +                           inode->i_sb->s_stack_depth) {
>
> I will make a delta patch candidate with his "Reported-by:" and
> "Tested-by:", I will try to send now.
>
> It seems I need to sleep later because my brain is exhaused,
> and always screwed things up, very very sorry about that.
>

Mistakes happen.
This is built into the process.
This will not be the first time that a fix patch is also a regression.
Sometimes its detected on the same day and sometimes weeks later...

Thanks,
Amir.

