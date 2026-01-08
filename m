Return-Path: <linux-erofs+bounces-1708-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C253D017F8
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 09:03:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmy8N54wpz2yG3;
	Thu, 08 Jan 2026 19:03:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767859412;
	cv=none; b=eGXJ2TVVOjCIRKf9Q58uURgkvL/b7+KvB4xGPWNoUG0oIIs3TURO2tfjuWXZVMSy+lOFhQE74kDyfi+eyC2b7S4zR4uuagFJCRi37KrZVMOiN2DpbU0wYjerxg5+YSx1xHWEExe+Br/GHW0ant93zDKNCd2S68VwtzF5MvI0dK3KFm+CQaHiJvWI7y8Q700WzjAqaIMAWx1ydbTo9m3DkNwCSoKOtQDJAKiSSuoyzugiPBZL9l5sZrSrf2TKxVAs8T4QIDSkouTHqByIe/1osiVpLVq0wXcDEDrr0lU+uoxd7MHnTUnEzoBXPEEv+leJgAeuGY4NQDoi8qhFQPZNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767859412; c=relaxed/relaxed;
	bh=U+SJerwHTLA8+W0cwIZXklA1oFCTKpQgbkxKozR1NC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxYNiP1sEaYAaCseaygi5aI0RMMU2x80muYl2tkLSU0EwcAb73MOO33zMZT86xaHMhgMFyN8ck7t3PoIuD+Tjz6YS/jwCHQY7pxsPmYSVgcZqru+InCd2i5W4Fyp12dLbDdGllOxTTafGLezH4AL0dtn7MaXyWOd4beRENFKXQ9au6EG44RjF1W4JuUfjpk85tEVocCRWWeSZWzjFVMnPBXz31YnyG17TfWXcA/+1EQJsQF8SL/92J+HqnrOX6P1dqTE9W/rYAY8dvhdwdWiuGtXfJmFI8iN9XxTH5UqQ0Z8hXZwDppak+LHpgsWsKIOQPoZoInrqLR449Efm4BfCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qts1tEFt; dkim-atps=neutral; spf=pass (client-ip=209.85.208.45; helo=mail-ed1-f45.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Qts1tEFt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.45; helo=mail-ed1-f45.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmy8L3j3Nz2xjN
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 19:03:29 +1100 (AEDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b9230f564so4039468a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767859346; x=1768464146; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+SJerwHTLA8+W0cwIZXklA1oFCTKpQgbkxKozR1NC4=;
        b=Qts1tEFt4cqWW83kV0dR2lis/C5q/NCaOBAXdmDZ3vF2Q4VxqxkSAzOpUaBvz/aFHU
         LYRA+g5KyVnICoJtZYpZ/X0LjA3eoAgb93SHdBsS8r24YePcI5GXPuA/warq8Mw7INsm
         hiiGapneC5Y97ybOZlLKGivLYGdHgtZ5mYQ5xrU9sWlCjDdtQ0SMztiuq5hYhyxJpRzl
         oAkOE6T/KV0OVanF09o0KAQRmRXaqjERSU8Jrm71v+FP1ylWFApPRnt/yTMRdaCtYv/p
         YK2ileG9QaAtlzNGiKAIja34gSZ9coSWK7NfGo0H8gEhSB3dowbYarrE5TgJrE0j14Ow
         Gujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767859346; x=1768464146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+SJerwHTLA8+W0cwIZXklA1oFCTKpQgbkxKozR1NC4=;
        b=sQVOP4+YR2YF6v8EQP7lltwBob1IBYkJ6Q3/mEdd6sBB5aZkF7C47ztm5DLN6p+B2r
         Nuble+aaFNOAImdvwa3X+3o0ygPimuLAbpOO+Grv7yvxNDKQ8VYzaPDOeq7+bO4lmqP5
         3/Y5i405paYTswxio2FV3Z2k6FPg0TOuw5g2jxfQ4EjI9tD5lxUhCrbfpT/p8FDj0jlD
         VmoaZb69YFPKyCuT63U6ajakxi3EzteI7TIjTmm18AgnaSOhDjYvDlGqhlgiwH9Ijgpt
         X0+3roUj0Dyer9nQYGGI1dz/GHEKuKdU333pPhEmQEJPmZdFOBgeILTXVeFls49sOSBV
         yU5g==
X-Forwarded-Encrypted: i=1; AJvYcCWkd3jAwH8PAvxXRPNv8AKo2dzo2U02xX3Tf1WFXHEY1QfSHm9mIm1dTu8nC84vrWahPDqMQVjTYohd8Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZF41hoDwuHighfC8u/NzamgM9OIaqEJfeoT52neulE4vTRwL5
	lV5swSjkcFd5X3YI6C3rByFYBNO5NEvGJJtGa3FZDMWXFOXI2Uic1mZRvUKAgT5k+1AvchlwfXZ
	J/zIXbnQEoitKbnWLfyTHzd5qQsCkDvU=
X-Gm-Gg: AY/fxX6qMXP1LSYjCvv1C1NdE4IiLjwBPhESWDCMiNHMw8EeEbOdJWwrtoN+PchU34v
	sjHT0x08YbwsMAWYAY9WL1nfAaI7xW5jCh1rx3Ma1lyFxpzuaLzHAunKmtCrx7qRXktm/hAw/OP
	A4dQ90yf7MVCcUx9TI+6CtwAVAfiTiyNsszFjfIxJCacL9dmhTyND22SIJGteNuJqgnoBjmH4xW
	s9lFg55x/hvZ586UK1cw/3GVK/PSA8pQsVAqyB5cTOu6wdLcJmDOuagfhYWD0AWuTqte/x7Bkrf
	69fAQhq8qGB3Jx5CkXgmDH3v0Jbf8Q==
X-Google-Smtp-Source: AGHT+IFXkdSRTClVJu8PDfr+VI0/zAKJXa2WRH+hFMcOI6dHYlkuVeMFSDVvXjk6XtiM96evO3C0I3EzP/b1zQWzUew=
X-Received: by 2002:a05:6402:1467:b0:64d:1d2b:238f with SMTP id
 4fb4d7f45d1cf-65097e50ce6mr4960585a12.19.1767859345811; Thu, 08 Jan 2026
 00:02:25 -0800 (PST)
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
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com> <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com> <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
In-Reply-To: <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Jan 2026 09:02:14 +0100
X-Gm-Features: AQt7F2qLkHUoZVw4R3ZHu1SqBeK3wO3ETQ2HzFmRIW0uNolONu-M8FMyj9K8OmM
Message-ID: <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>, 
	=?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>, 
	=?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>, 
	Alexander Larsson <alexl@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>, shengyong1@xiaomi.com, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Jan 8, 2026 at 4:10=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2026/1/8 10:32, Gao Xiang wrote:
> > Hi Sheng,
> >
> > On 2026/1/8 10:26, Sheng Yong wrote:
> >> On 1/7/26 01:05, Gao Xiang wrote:
> >>> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacki=
ng
> >>> for file-backed mounts") bumped `s_stack_depth` by one to avoid kerne=
l
> >>> stack overflow when stacking an unlimited number of EROFS on top of
> >>> each other.
> >>>
> >>> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> >>> (and such setups are already used in production for quite a long time=
).
> >>>
> >>> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> >>> from 2 to 3, but proving that this is safe in general is a high bar.
> >>>
> >>> After a long discussion on GitHub issues [1] about possible solutions=
,
> >>> one conclusion is that there is no need to support nesting file-backe=
d
> >>> EROFS mounts on stacked filesystems, because there is always the opti=
on
> >>> to use loopback devices as a fallback.
> >>>
> >>> As a quick fix for the composefs regression for this cycle, instead o=
f
> >>> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> >>> nesting file-backed EROFS over EROFS and over filesystems with
> >>> `s_stack_depth` > 0.
> >>>
> >>> This works for all known file-backed mount use cases (composefs,
> >>> containerd, and Android APEX for some Android vendors), and the fix i=
s
> >>> self-contained.
> >>>
> >>> Essentially, we are allowing one extra unaccounted fs stacking level =
of
> >>> EROFS below stacking filesystems, but EROFS can only be used in the r=
ead
> >>> path (i.e. overlayfs lower layers), which typically has much lower st=
ack
> >>> usage than the write path.
> >>>
> >>> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after mo=
re
> >>> stack usage analysis or using alternative approaches, such as splitti=
ng
> >>> the `s_stack_depth` limitation according to different combinations of
> >>> stacking.
> >>>
> >>> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-=
backed mounts")
> >>> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> >>> Reported-by: Timoth=C3=A9e Ravier <tim@siosm.fr>
> >>> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [=
1]
> >>> Reported-by: "Aleks=C3=A9i Naid=C3=A9nov" <an@digitaltide.io>
> >>> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=3D+JP_-JjARWjo6OwcvBj1w=
tYN=3Dz0QXwCpec9sXtg@mail.gmail.com
> >>> Acked-by: Amir Goldstein <amir73il@gmail.com>
> >>> Cc: Alexander Larsson <alexl@redhat.com>
> >>> Cc: Christian Brauner <brauner@kernel.org>
> >>> Cc: Miklos Szeredi <mszeredi@redhat.com>
> >>> Cc: Sheng Yong <shengyong1@xiaomi.com>
> >>> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> >>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >>> ---
> >>> v2:
> >>>   - Update commit message (suggested by Amir in 1-on-1 talk);
> >>>   - Add proper `Reported-by:`.
> >>>
> >>>   fs/erofs/super.c | 18 ++++++++++++------
> >>>   1 file changed, 12 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> >>> index 937a215f626c..0cf41ed7ced8 100644
> >>> --- a/fs/erofs/super.c
> >>> +++ b/fs/erofs/super.c
> >>> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_blo=
ck *sb, struct fs_context *fc)
> >>>            * fs contexts (including its own) due to self-controlled R=
O
> >>>            * accesses/contexts and no side-effect changes that need t=
o
> >>>            * context save & restore so it can reuse the current threa=
d
> >>> -         * context.  However, it still needs to bump `s_stack_depth`=
 to
> >>> -         * avoid kernel stack overflow from nested filesystems.
> >>> +         * context.
> >>> +         * However, we still need to prevent kernel stack overflow d=
ue
> >>> +         * to filesystem nesting: just ensure that s_stack_depth is =
0
> >>> +         * to disallow mounting EROFS on stacked filesystems.
> >>> +         * Note: s_stack_depth is not incremented here for now, sinc=
e
> >>> +         * EROFS is the only fs supporting file-backed mounts for no=
w.
> >>> +         * It MUST change if another fs plans to support them, which
> >>> +         * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
> >>>            */
> >>>           if (erofs_is_fileio_mode(sbi)) {
> >>> -            sb->s_stack_depth =3D
> >>> -                file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
> >>> -            if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> >>> -                erofs_err(sb, "maximum fs stacking depth exceeded");
> >>> +            inode =3D file_inode(sbi->dif0.file);
> >>> +            if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> >>
> >> Hi, Xiang
> >>
> >> In Android APEX scenario, apex images formatted as EROFS are packed in
> >> system.img which is also EROFS format. As a result, it will always fai=
l
> >> to do APEX-file-backed mount since `inode->i_sb->s_op =3D=3D &erofs_so=
ps'
> >> is true.
> >> Any thoughts to handle such scenario?
> >
> > Sorry, I forgot this popular case, I think it can be simply resolved
> > by the following diff:
> >
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 0cf41ed7ced8..e93264034b5d 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
> >                   */
> >                  if (erofs_is_fileio_mode(sbi)) {
> >                          inode =3D file_inode(sbi->dif0.file);
> > -                       if (inode->i_sb->s_op =3D=3D &erofs_sops ||
> > +                       if ((inode->i_sb->s_op =3D=3D &erofs_sops && !s=
b->s_bdev) ||
>
> Sorry it should be `!inode->i_sb->s_bdev`, I've
> fixed it in v3 RESEND:

A RESEND implies no changes since v3, so this is bad practice.

> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibab=
a.com
>

Ouch! If the erofs maintainer got this condition wrong... twice...
Maybe better using the helper instead of open coding this non trivial check=
?

if ((inode->i_sb->s_op =3D=3D &erofs_sops &&
      erofs_is_fileio_mode(EROFS_I_SB(inode)))

Thanks,
Amir.

