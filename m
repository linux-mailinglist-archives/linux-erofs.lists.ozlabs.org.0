Return-Path: <linux-erofs+bounces-2836-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMYBCH0Eu2kgeQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2836-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 21:01:01 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C792C24A0
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 21:00:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbfpH31lsz2ymg;
	Thu, 19 Mar 2026 07:00:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::634" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773864055;
	cv=pass; b=cY4td4wss3XypPuRsXrzUfnVnVJfCz4OodDgDrEsem+mAOYVwRkI36IpgCtC2D7lXQaURNccHs2ckYMJMsKDlVFEqplycggoqUuf7cURGx/kdhBNrcEn5wE1ldBla+NVtuDZteayYXEje+WRVPxYw19Vk1Hmqgoyk2XwalBoEglSFG92GxKT9BPvak9R5yJyqzDpolM+NYIhd4rjCIoeZt2JPPnKaLkggjtMFPuiSD0kJkiaCy72ZhPKjn89u6pHbiHtWHHA8tpGJbGnUmaPwJpvsI4YsdQcCFu4Ork0+nKlnEcS9s0rhxY9xecp/16H3VqPeD/Ik+RjyLiX0jcwDw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773864055; c=relaxed/relaxed;
	bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBceeDyGM8VuaGon/4dZkttPSzhDeg4A1nNCwTXhqAAwCMIv+5HHKj3WWVtUGIftbcQlbV79oqSIpHMixPp57YH+tSXSiFlKmVMm5KiwUmGD+ROZPIMAffAekeTaXk7szrdAcVNivKWErcWWYYggEhYzkf1amWNkA122HUUPm/R8fLsVQITjIiAw6+8hUpMfz7HQgiHivo6MvUEoeIrvZAYXRAsvORCMMfhgjtmCvqeemDbSh6ZLXstJ66kYtXyD8ZInWDPapCLnUmq30Ssy/mOCLrlkDFsNqobRhPqava3lZiSiODakR4FlGV82smpKOj0cg1Qb3Y7g70KqQqu9DA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Q2wmpjHM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Q2wmpjHM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbfpG1VlZz2xYk
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 07:00:53 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2a9296b3926so1858785ad.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 13:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773864051; cv=none;
        d=google.com; s=arc-20240605;
        b=ROyS3C9Mp8BXSj6oiBtau7yDTCEZlMoQtf/S0BUPwTalnRxP41+3TNxyGsuLQJPipD
         jCF9noBM9Lo0DlnzOUMtjGpH7/8rRvxTSdirI0rTgxhqDuK22X3HC/ksTgYM4TOzO6IH
         U6faAR8yTpfpfVLZmRrKiwsIRec2TrrNakbgdNGCpLmQWuxPljP5KeDlcK1gjHZQo1aL
         snI5hnwIU+ENj0tXU452q9Jjb+uX+9uhRbx/E7O+bbEWlWEE4a53wTmuwvBoyfJHzw2A
         oIWGsK6gQ1zVbBuiuw2V3j/n7RTO8AdjLNfEgHpf/mLbfA+QmgHNmgJbxmXQbkyn0SWZ
         w7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        fh=mtgJ+oubBQWoPCXTMCn++vPlKvTAqxFHlmfD61ab+Nc=;
        b=KwwK8t2Lf2WDFgc6BhDj8zxO2gabk/uH2aVaddx1caKj8n7+W1lA+eExYi7mc1Xdu6
         dkKxKuoAbKjI2CS36MVA9pYOkDqhwQTzJ3k/lZz0C/+zSDRNnmwkGUYtBE4AM9mylrcB
         TdwzAgUGy4D7riMlsKISTbSSUhrGnTEWS+QP0JKiAadKu5QKYMFiP6gTvPt9goiomuLe
         u+uuTVp0w/TTtVpl76hhFoWxRBzzwNfVn1isYAc/5r5NCQu1k1znsYqie1s+IwEF6zP5
         2aBsXzJpRlaQeKXx+8NEwormqoicNXrB4WKeh2QRkAL5ljVonOjt7MnQdLRH2x+hkyE8
         XhJQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773864051; x=1774468851; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        b=Q2wmpjHMv4Ek7lVLWioF5MBYKVfan3czEMHvOVMBxlfG+wbzZlzVd+mVbo3KeDWDyA
         I68zf7pYTtNRuDIEDyqtqH0JPn4iPIc4HDCdZXgCbNG+TEsUEekOUDWP2yBD9jjqSMWu
         rhL9IqpyEY0BVxYzWFDrQVOLy7zbJWyUvoP1MPSpUjdPANtKFfDPLr91FKl/VX0ldh5/
         F/HvFCg2X1rpFlBoq7u2lwowk5uuaeDs9Sa2tpgTlpZEHHbPkmfw3MjOFu8pTR7R9fKi
         RKLnVZLow1fHOwDd2Ex9sU6OwshlG1J/K07Id9TkDEpWXtUmmp7h5RbcP4ShaRcasl4f
         9oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864051; x=1774468851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71OKjSWJ7h2Q1GFZJc35pK1JHDHtKN/E4Pws9ixreXc=;
        b=JBNqwdhqzMVvTHsXqf/kV8FHKKSeF8OQ6gmVlIkiMnUGk6sldRQ/ocfZfcQE8ihswm
         4CxHrynLcGiNfgKBd5NgBVn7vUJjPbHN5KQv0QnNdCmSzwkmINjMT5DIefKlWDtOZ88l
         DhbTCgkWHR9H1SvQqS/IVbvgz3pnj/2sYbcpcCf5ORPi+3pUV5IrY1+ZBhPQiQdC66eF
         Z/aqN0jZAkCTT+Y8UkJ533Azh21pPKnrfjIYIbVp7d+lvtdEjuH8iqt8KdqITbsMlENT
         7Tq6uBXNXVIbPiaj1DronjJcv9lEN4D56SRZcD/NFXoxBK+dtTnLPDO4RcUzcLnhVh3g
         ocpA==
X-Forwarded-Encrypted: i=1; AJvYcCXvk0AimOJzDvh5yJWVP+ZZlxQvIv1uGpfvUCPHyUwCgacRigiMCVzSqQwhS+dj8GdZkg7w7un1JOjIZg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKLgFnomDzOKfT0GSpbdE+SdRjW82YPzaB48BYtayUTTlu2lTH
	3hOjlbRLoVInpqtGM2OzS/mKe3gM/1e/M25+/qGUvTcGMRXjboIIBYpLKNOFzzPjo0Vrv4+hJoL
	OeoIyVLhJNaza+HVtQCnMsEEM77UwrXFe89HhTMHK
X-Gm-Gg: ATEYQzxHe9Pqleqcn0DMwc1aYvE2FfFBVfooVG/KOtfVJ9gsq381D2ftji7e/L+YIOv
	D+FSLTr0eU8oAkAFR3/pK8NXMUd7eulbcP+izzVcBAJFaz5/P8NEOC0slktcJegYeBTcwkJNVmU
	lbdHWLsnzYOLf6TqnU/kmE+cal5weV7KX0s/0yYG0+SpWlTz90FaNmaedYcBh+1vvycuCn8wez+
	44ZucXqjRHRoRIwy8MZDfEFPxuCD7/LCKen2UbN/qhet7cH9EYc+Z4DS87FfIz+swMv/k/wl4pb
	YqiyQREYtBz2unbIzA==
X-Received: by 2002:a17:903:2a90:b0:2b0:4158:c9d1 with SMTP id
 d9443c01a7336-2b06e3e5bacmr54910065ad.36.1773864050852; Wed, 18 Mar 2026
 13:00:50 -0700 (PDT)
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
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-6-paul@paul-moore.com>
 <20260318-einsam-sellerie-2d547dd338ee@brauner> <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhfvS1SCkp504uDuBmgqSEBYaQDDVAm+JY=w_2fKLbQsQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 16:00:39 -0400
X-Gm-Features: AaiRm50bTirLC51vuYEkGlExlBIJP04T2IlKkXqzaEFW_Rpzh7aQ_TFopQtvPJk
Message-ID: <CAHC9VhS+83FZoyVOV_tKHOBtVSwK76TS-gbc=cKzL5QK1P21Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:brauner@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2836-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,alibaba.com:email]
X-Rspamd-Queue-Id: 44C792C24A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 8:07=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Wed, Mar 18, 2026 at 11:57=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Instead of storing the user_path, store an O_PATH file for the
> > > user_path with the original user file creds and a security context.
> > >
> > > The user_path_file is only exported as a const pointer and its refcnt
> > > is initialized to FILE_REF_DEAD, because it is not a refcounted objec=
t.
> > >
> > > The only caller of file_ref_init() is now open coded, so the helper
> > > is removed.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> > > Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  fs/backing-file.c            | 20 ++++++++------
> > >  fs/erofs/ishare.c            |  6 ++--
> > >  fs/file_table.c              | 53 ++++++++++++++++++++++++++++------=
--
> > >  fs/fuse/passthrough.c        |  3 +-
> > >  fs/internal.h                |  5 ++--
> > >  fs/overlayfs/dir.c           |  3 +-
> > >  fs/overlayfs/file.c          |  1 +
> > >  include/linux/backing-file.h | 29 ++++++++++++++++++--
> > >  include/linux/file_ref.h     | 10 -------
> > >  9 files changed, 90 insertions(+), 40 deletions(-)

...

> > > diff --git a/fs/file_table.c b/fs/file_table.c
> > > index aaa5faaace1e..b7dc94656c44 100644
> > > --- a/fs/file_table.c
> > > +++ b/fs/file_table.c
> > > @@ -56,24 +57,44 @@ struct backing_file {
> > >
> > >  const struct path *backing_file_user_path(const struct file *f)
> > >  {
> > > -     return &backing_file(f)->user_path;
> > > +     return &backing_file(f)->user_path_file.f_path;
> > >  }
> > >  EXPORT_SYMBOL_GPL(backing_file_user_path);
> > >
> > > -void backing_file_set_user_path(struct file *f, const struct path *p=
ath)
> > > +const struct file *backing_file_user_path_file(const struct file *f)
> > >  {
> > > -     backing_file(f)->user_path =3D *path;
> > > +     return &backing_file(f)->user_path_file;
> > > +}
> > > +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> > > +
> > > +void backing_file_open_user_path(struct file *f, const struct path *=
path)
> >
> > I think this is a bad idea. This should return an error but still
> > WARN_ON(). Just make callers handle that error just like we do
> > everywhere else.
>
> OK.

That's good, I can remove the FMODE_OPENED sanity check in
selinux_file_mprotect() now.

> > > +{
> > > +     /* open an O_PATH file to reference the user path - cannot fail=
 */
> > > +     WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> > > +}
> > > +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> > > +
> > > +static void destroy_file(struct file *f)
> > > +{
> > > +     security_file_free(f);
> > > +     put_cred(f->f_cred);
> >
> > Note that calling destroy_file() in this way bypasses
> > security_file_release(). Presumably this doesn't matter because no LSM
> > does a security_alloc_file() for this but it adds a nother wrinkly into
> > the cleanup path.

The alloc_empty_backing_file() function will call init_file() on the
O_PATH file which in turnwill call security_file_alloc().  We depend
on that behavior as we need to set the creds properly on the file.

The tricky bit is that security_file_release() is currently only used
by IMA/EVM; it was created when we folded IMA/EVM into the LSM
framework, making them proper LSMs and cleaning up a lot of the hook
calls in the VFS.  The commit description provides some info on the
hook:

   IMA calculates at file close the new digest of the file content
   and writes it to security.ima, so that appraisal at next file
   access succeeds.

   The new hook cannot return an error and cannot cause the operation
   to be reverted.

As O_PATH files never go through the
security_file_open()/security_file_post_open() path, O_PATH files
should be ignored by IMA/EVM (which makes sense, as there is no data
or xattrs to measure, update, etc.).  For that reason, skipping
security_file_release() should be okay in this particular case.

Other LSMs which allocate file specific state, e.g. AppArmor, in
security_file_alloc() should free that state in security_file_free()
which is handled in Amir's patch.

> This is for Paul to comment on.
> The way I see it, security_file_open() was not called on the user path fi=
le,
> so no reason to call security_file_release()?
>
> It is very much a possibility that LSM would want to allocate security
> context for the user path file during backing_file_mmap, when both files
> are available in context, so that later mprotect() will have this stored
> information in the user path file security context.
>
> But in this case, wouldn't security_file_free() be enough?

See my comments above.  If we wanted to look into removing the
destroy_file() special case for the user_path file hanging off the
backing file I'm happy to work with you guys in the future to sort
that out, but I'd prefer to tackle that at a later date as it could
potentially have a much larger footprint than this patchset.

--=20
paul-moore.com

