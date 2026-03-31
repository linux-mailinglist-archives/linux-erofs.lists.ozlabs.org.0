Return-Path: <linux-erofs+bounces-3128-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JkdHPIty2n8EQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3128-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:14:10 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B13635E4
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:14:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flBWL5R5rz2ybQ;
	Tue, 31 Mar 2026 13:14:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774923246;
	cv=pass; b=cTQ0veXjmOBubXiUOEudiHKCk+NeY81kSFcSf/OkjF8581Hc3ftKGqLVh8YmJ3XyeVDJ1sv47DfMFKku5TMVzfP9L3zCLUL2wJN0yPV2YngP8oZIyZ7s7t5IQetvJMSXjbX+UaUJ/iQGUeVgjhKk1dTkeELpxEjvaNnGa3QJ9qG8/+cbtkSemJp0HwUxWKCXQTrpn1wFzIv0FogQY5mJPkW5bYWJY+T7ANUVL75r67tF6gxmy3XgBCo6VrgGsZuL8LPKOBVI7BhQ2c53ZqRqbCF/mAiOA835czHAOqAJ6KDlwhVfUgDkV5erVodfFcLZEmKx0nFhPTgDKNJatWNSJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774923246; c=relaxed/relaxed;
	bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGg7T8rJxlL2OE7Ip2nehtFCrFaMgF5M8GcIMeFf+HPjLNCGzF96nexMOQyzFCqEuCRJeMklBHft/RRQFnkO53AiWvV96xBnttlSes55kUjB5r2ZZPSyJxlUjiMElMgl+MbMoMveSeoQanSgjHyiDZ66i81YolO0HKz4t7lpd3quZ4TJBCmzPx1GgXM7IyvwEnsRMkrItqcrAe8lrHceD1/EryzOuxxojSGNNEyr2BnC33mbhgSojEvKLBfwxEGjRukE0WJlomXFvqlGbbNA4pUCjoDe1e6A2H6AVXh/wfIGDz3+BX5qQz78Fl4kqHBQKvrDNI21vE1lS1jw6s5TRQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NLODuv6j; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NLODuv6j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flBWK3KDqz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 13:14:04 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35c1a131946so2998553a91.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 19:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774923242; cv=none;
        d=google.com; s=arc-20240605;
        b=d7AfjwG9qVb2D6cBgr7vV4rSgeu62RFmHpKEkmyl65isj844Va3nMyoZbgoEDks2EP
         M/z50PoYnEDWDOfnnPjkw+gL9JX8z+uxNV1wiT4gArTW959D1DE+hN9ksNjLhE4Um6id
         SEvhKviIR1bkLhZVnSUNe16B5bMFR2SAiAOMFN19krzaIY/9WpVYGM2c/RgPJJ38c9K6
         X4rogN+Wi69tfybSZMtunnB3O3Dd3+SeRVxLWlVG3xNHx1/H3XNqAwJ2aGsebbz3m3Ze
         9hqU6D0q1sX/vcVYcxgWhfQHXo8k9/72GOAmNHUlEpmPYnDFkjowpad1t/JJSTldSJXG
         6kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        fh=Cnbnl1zBAa4UuRW7smftSuV20RZhuHV8kY3dQ2Ywkz8=;
        b=fL3IabEe4e/U4gc3koBc3JXE/0lATigQHNNXWAdIEbpmu43tHmMrH71Hjpcb6wi6Lc
         VrYRgSlMz0ln0iTVJxAAoc5mJYA4iBHtJNrUM8ahkTiflv91UDB9Qawx/3WGc7m9N+AY
         PegdsQZrypIeF7ocfGAE1QijW0S1nwkCbTkWf1ojOy4/EiSTeg/94FiV5GSTFgLI9Nij
         JQU7DnVsxoycHlHgQ16GBZTVMDW8jjK8ccv2vYWwoeVVvs9PcmS5BzCf72XN+YdiPxj1
         0OkEKDytAx672pNcughmQWXwn+P5Ik9mhyJ9cnLyx6HpRfmCrKzXYQjAJTnMFZ6xz+s9
         WKCA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774923242; x=1775528042; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        b=NLODuv6jt9k2gePKXJLlrHtTUc3dQpfb2lKCVitt7Tjtxv9ZjFYNDuLbC6Nr9E0CzK
         d1QIElVoSiYwDVzuuf8f2NDaNCxq0tZidgLhvBcfFXy6fMx6yLDnTG1LrcbZQWU0N07e
         oq9nVs7pBDDsShZNEn5VvI1Ue2LRNjepVttimctnPsIsy96ctWwEvX0dgiEJ2H+7sQTK
         9I7XYgfrFtv5Cboi9xQWyJeL9ORIpFeqAGm6Br5VQr6lPYJl0S5nEuQtUMAWtzvkbRJ3
         c6UfCWbUvy5yI3ULXds4NJ5nrZH/+wMQh2IKsCZN+oPWZGJJVNRbyP4BKsvEuuGHKPId
         k3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774923242; x=1775528042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTY73uli4S8kcgZc+rHMQS5AIJA2/isaeJaubiJWEjo=;
        b=fzkN15scUE7KUKGk2+Fc62eU239TvIWnVXApYeSThDHZobVvIsrl7hPmY+yYDxRP99
         kRInSdYF96+ADeoK/oAZ/t1ouJl1GLj5V0f114t+rEbOLuZkuyd5So+j/ao0vS/cGCt6
         oEPzbbYDNbv3o7o/yalO3jHO1ZSZSoUcPLm1IOvo4n299rQXVFVd2cmr64Ggr76N9ZPA
         s+L9/RkEK7/qZ4iFuBzINdhxRNXaaYWlLrQaA/O/UZ/ASpb7wV6Ll1Y1nA/ZMM5boSIk
         nrlJXGcJKkctMYfqtSOSESmQs7RW58e9sD9PX0k6i3cEOoWrMMS7PC1pjQDcywM5YEOF
         k4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBGYufXMC+nkftkf4m9BJEP6+PCnzEQ9HCmxoXk8/HuOS7TgqT9eWs6ewarZP4aoDatkzVSa8H8QdM2Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJ/dkikTt9SO9Gl/RUsp82/1lttz2D6LgNt282pUmpqIdY4H+k
	J2azEgQkTZOdrC03myDp1xzWBr9agWGR7HVYjOij75gmyYD+UD9YoIUIFzKiHVZD8iltWf8LzbV
	miJsZBaaFc4dcHHgPuRY/jaRIsMNDgoyxbh3jgoKH
X-Gm-Gg: ATEYQzw4hMwZOo7R5R5E7hh+/gObtmNDKt2xfsT2723QW5YvyImVxzb/HH8vLS5npC4
	83XOpNfkj6PwbM7JXqhUQ8z0btn0PGK4I0DybBR8ggWa3boJ3N5ldmGOvAU5cxwg9BoCxsexPlH
	/rZSfYqf360B/i0r3aIZuce8qyAOKiHRUlSAdB/zgi9CcuTTqaG9qnZn1WtVnVT2reyomnRXqq7
	AbyvwpnTWJfm2DCqdXtBT4InoQg7H18j/0FfDMO8zaStSKBHNwpXg5Fhl1S7ObJIYn/94SZzR3A
	F+3dgys=
X-Received: by 2002:a17:90b:1e4e:b0:35d:aa02:d776 with SMTP id
 98e67ed59e1d1-35db8e5d15amr1344113a91.2.1774923242128; Mon, 30 Mar 2026
 19:14:02 -0700 (PDT)
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
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
 <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 30 Mar 2026 22:13:49 -0400
X-Gm-Features: AQROBzAeO-pr44FHCmrznY1FfG77xj1P2susMVAMZI8kAhJNYbfNcCYgp9cpQWg
Message-ID: <CAHC9VhRvJwrp47-A0frOjJcTmiLr0G218idQ9obXBrNpRWuDUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3128-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 859B13635E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 4:35=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created ...

...

> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..0bdc26cae138 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -50,6 +50,7 @@ struct backing_file {
> >                 struct path user_path;
> >                 freeptr_t bf_freeptr;
> >         };
> > +       void *security;
>
> This needs ifdef SECURITY

Yep.  That will require some other changes, but I should be able to
keep those fairly limited.

> and the name should be user_security

I'd strongly prefer to keep it as "security" both because "void
*security" is a very common pattern in the kernel when adding LSM
blobs to structs, and we don't know what each and every LSM may need
to store in the backing_file LSM blob.

> > +void *backing_file_security(const struct file *f)
> > +{
> > +       return backing_file(f)->security;
> > +}
>
> I prefer the name backing_file_user_security()
>
> Terminology here is very confusing but when saying
> "backing file" it is more natural that one is referring to the
> backing xfs file with overlayfs has opened.
>
> The "backing file" already has an LSM blob f->f_security
> which is fair the call it the "backing file's LSM blob" ...

From a LSM dev's perspective, I would call file->f_security blob a
file's LSM blob regardless of if the file is a user or backing file;
the backing_file->security blob would be a backing file LSM blob.  If
you look at what the SELinux code does, specifically in the
__file_has_perm() and __file_map_prot_check() functions (newly added
in this patchset), you'll see this supported by the code: the
file->f_security field is basically handled the same regardless of if
it is a user or backing file whereas the backing_file->security field
is handled very differently because it is a backing file.

While I think it makes sense to match the accessor function's name to
the struct field, ultimately I care more about the struct field's
name.  If you really feel strongly about changing
backing_file_security() to backing_file_user_security() I can live
with that so long as we keep backing_file->security intact.

> > @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
> >                 percpu_counter_dec(&nr_files);
> >         put_cred(f->f_cred);
> >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -               path_put(backing_file_user_path(f));
> > -               kmem_cache_free(bfilp_cachep, backing_file(f));
> > +               struct backing_file *ff =3D backing_file(f);
> > +
> > +               security_backing_file_free(&ff->security);
> > +               path_put(&ff->user_path);
> > +               kmem_cache_free(bfilp_cachep, ff);
>
> Not directly related to your patch, but as this is growing, IMO
> this would look cleaner with backing_file_free() inline helper
> (see attached path).

Sure, I'll include your patch in the patchset.  I'll also fix the
comment style in the patch to match C style in the rest of the file
(I'll note the change in the metadata).

> >         } else {
> >                 kmem_cache_free(filp_cachep, f);
> >         }
> > @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                     const struct file *user_file)
> >  {
> >         struct backing_file *ff;
> >         int error;
> > @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >         }
> >
> >         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> > +       error =3D security_backing_file_alloc(&ff->security, user_file)=
;
> > +       if (unlikely(error)) {
> > +               fput(&ff->file);
> > +               return ERR_PTR(error);
> > +       }
> >         return &ff->file;
> >  }
>
> There is an API issue here.
> in order to call fput() we must ensure that user_security was initialized=
 to
> NULL (or allocated).
>
> I don't think that we want security_backing_file_alloc() to provide this
> semantic and the current patch does not implement it.
>
> Furthermore, user_path is also not initialized in the error case.
>
> Attached UNTESTED fixup patch to suggest a cleanup with
> init_backing_file() helper.
>
> It also changes the variable and helper name to user_security
> and plays some trick to avoid many ifdef SECURITY.
> Feel free to take whichever bits you like with/without attribution.

I think I've got a cleaner approach than what you've proposed, let me
code it up, test it all, and I'll post a new revision of the patchset
soon.

--=20
paul-moore.com

