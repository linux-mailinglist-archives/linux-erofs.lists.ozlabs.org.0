Return-Path: <linux-erofs+bounces-2421-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOLpAYOtn2ngdAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2421-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:18:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6179A1A011C
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 03:18:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLw9p6BBpz30BR;
	Thu, 26 Feb 2026 13:18:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772072318;
	cv=pass; b=Bm/bjEBVYxLLD6w1d5ngw6kbk6REb9/HwfzKdhbfR1yLt02LPcd0s/o1HMmDUJtfm3AOOZKS9mNOUS5lnXmBo316TpvspHEWLxu5zG9S4VqUvpEUF+G8lCxK/L/xgYf+PC2/r7hOrxA2i0J0s436Q1H/P72XYBQgxLHhM5/Dw64zd03wTMHdrjOA9rqh+siu3nr5DuPq6xaYYdltiVFhJRVT8VJbYaTADzU0YE1Hxjz3skdxL+CX2cVxCdUu0YYagfnHZ2RsH2kU/REYYeGaLLVttKIPwt7rpK7rsTO1L/LSlu0m7jS522D833TyoAnA1svFqN39mrS9H44kSG/fBA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772072318; c=relaxed/relaxed;
	bh=Pj4iPG4SesBLhTNjSDoXy5lY28inJzx+uZM/UiK/Qng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrZDXBBcYZ2dN84o4tD/i8fXaSX+jPoJ0vzj4Mf9YDL7ZHYKb+HPCsAfGXfHqJzK7zsNdlyUThflp1hzqG513BpYtoMwnlf1eqlQRY9XA1Hahuuduo3bNQ+Gn4lmaUFSNaKdcXU+SNELkFDJEpcCao0eRhJ7bsLamYxO7nAsCdG32ZUCT6FOlDctesUnAEAPQ+iblNWqTUeIIxoOhyjzFXxToqsLJEaUHdWpufVjHSNgyN50EoI9pdlZyU0jAoF7a/CAUg/nCzIWEgGE57th0u1/nBC6Aq/qLZx75e8TiHNvhtXzg65zHVxeBLvZHknsPG0qYx8ULjsfyyiMCWs7Bw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a3VjOp8g; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=inseob@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=a3VjOp8g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=inseob@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLw9n1Xvpz309y
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 13:18:36 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-65f3a35ff13so5803a12.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 18:18:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772072312; cv=none;
        d=google.com; s=arc-20240605;
        b=FEGCJ7n1S381n5MxlMBO8TuSBo0NtbSileKWEUDi3iOQwCVVuuKqZYum2JNWouYy4i
         /TKLnMCK3joE/gtm7/ZTJd2O9zt2nfT69c6o2GYuj0VbiF5WgQo6KH0622c4URhGR3Ft
         nYj36QYBsw+m9vBI7xBPGUmqlYTyPBrlrJnm+dd1N5x4a5/2S9ZiOGebwQHN02R7BGgy
         lhAI3iTgnPqx99voi9BiKnJipeOnObdSjzaLUpruUdHJOBiTc021a/Ed8cmRYJmZsXLr
         iE0o8BTbos3uD8ttSpFwyJtlrqjw3cF7F9niUc0uqHNxC18NCBda7RNsW5NmSDttPByE
         TR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pj4iPG4SesBLhTNjSDoXy5lY28inJzx+uZM/UiK/Qng=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=Uj/dMPL1MLk1JtqkjOAWBhXd72zlKAJbXL4aeWSBBhStYJk05X7PdcN0t0wkEutEps
         Ugu7JMpvD6p6Ez8A1AAxzkwG3veGuDVSC2tpYDNyKykAm3eFApufbl4gbzq/a3OO9cXB
         lRUlF2PJtEv+0VDiz1CxEIggf+8MYJ70nnEY896+UP0kOMBw+55h6Pm0O3x6mRsTYSDT
         k32yYwaXkTvpzut+NTzbHTlJPXGEpTxO775pF1IL+Pl9G3U7WIUeWR4J4cVYUsFRZNbj
         ZgzFdGYfN8X70h/Rd6cihVFzxpu0NocB04i70S1LTENkb248r+32XbKPpBy9McPz//U7
         vgNg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772072312; x=1772677112; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj4iPG4SesBLhTNjSDoXy5lY28inJzx+uZM/UiK/Qng=;
        b=a3VjOp8gHzWXP8pYYuJJ3Dm7bYv7/d4MQtySli1NdfbGPepo2Vy+fdLrJc7c6aqX+z
         FQ4YOXtlN0A8piswWioC6EcYSGnulCU8XykBJn9zDLVb495MGrprwLdugxgsjVIR5edt
         A9KY9WBLj03JLv+0NJCsR2wl7oV9e5QwHi52EPfaLSqge+wO8uqzvdQVneTf2TlHEAMg
         aOYB07MzsZ6QiPJX4jULBjJMqcwnDiD4hgW1aJs6Z8HfOImSZJ+sL/YW6zQE6McqQmCe
         qCQlenwbVjEUqagPH/0pMV9aBXUGxbw6wHGog+IZ/3XFDncSFmwHGcZXOFOAKhJT2Z8m
         SIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772072312; x=1772677112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pj4iPG4SesBLhTNjSDoXy5lY28inJzx+uZM/UiK/Qng=;
        b=c1qau3g40JKgoVwqrbMM1XsgIiRyx6fmE+WHqcuhl2sqIHSpV2sY2a9Uckek8cU8tA
         4bKogXZSeY4gfkL+sTlVHE2Ep3AyTAu/NFTk4tPzC4c2qrKiK75mS0T7LyGFI+nresJJ
         ueBnq1Nla3NpdlBu0zBBFformPTaLWYGGEIc3CNnIsE+lx3MOFtOhpKUNDTM3aUZvjqy
         Y6V8JtZbfB3Sd+GvrsSJfZPLKtORECEdBjFEIvFjVy+5qyV1iCdx+nI3z8HP9walnFMX
         zlNnHChQ0nV5+2nhd8yf+pXRsLt7paV9yRcMp566A6ERzLd9j0dlUixB3Dnn0La9x5TA
         FsBA==
X-Gm-Message-State: AOJu0YxsdzMuQZowZzO+J3hknZxbJC01cUUX2nxaK+mEG0ZRKyhWb85Y
	gvUNG/oQlFpcItvuOJwYppICtb04txNvaFJnntxgYcRmgkCiBumxF/jAwLpVjXzdJNmxDWGpOw8
	Q4fxKpcqutzZH0DjNpk8tD27vNjI+djq0awbcn+iF7zIDNMUv3LPgkG3mtMo=
X-Gm-Gg: ATEYQzwZ4KF8BTFrJ+6Qst6khvEqgKFd6U7NYPQdI1wM23sVYm/dCbiovpVWLBiCv0y
	j6kST9W+GYvL9xGzkav0OIR/5Q/wQYxLq6qWPuvcxSVj4QOo2IDAMUBE2yw9Jbu0qbybVfFguXK
	I7lU+KPk9/nmyVLzapGLBCWh+FNpHQ50OC6Mt9sQ/yvzcWylrqYchG0p+uf6TOXEsQ/lt1FZi2E
	goCZ6YbPDpp/1PxzgOBaHpd/ZgIPcdYs3VuE5cWhirhL2jcVjufPOxwnnmlTadQO4bZ+KKzPEtV
	kVrGQuEnGlDuiCr7IgB61wWoOk+3FdrdI6/S2g==
X-Received: by 2002:a05:6402:5d4:b0:65b:e9ae:5fe5 with SMTP id
 4fb4d7f45d1cf-65fb02981b1mr15070a12.5.1772072311808; Wed, 25 Feb 2026
 18:18:31 -0800 (PST)
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
References: <20260226005913.3703242-1-inseob@google.com> <de02ce86-c2dd-491d-b418-087ddde5b31c@linux.alibaba.com>
In-Reply-To: <de02ce86-c2dd-491d-b418-087ddde5b31c@linux.alibaba.com>
From: Inseob Kim <inseob@google.com>
Date: Thu, 26 Feb 2026 11:18:16 +0900
X-Gm-Features: AaiRm53VQBYfYGBSkKpNmQkbtydaNVB5sLxbzTRst6-OeVvzVkeDLkx9qa6c1Ao
Message-ID: <CA+QFDKmznnFDVM7OBVWNQdTzXUu3o1vq0ALZjq54Nb530tpL6w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: support extracting subtrees
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[inseob@google.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2421-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inseob@google.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6179A1A011C
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:50=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
> Hi Inseob,
>
> On 2026/2/26 08:59, Inseob Kim wrote:
> > Add --nid and --path options to fsck.erofs to allow users to check
> > or extract specific sub-directories or files instead of the entire
> > filesystem.
> >
> > This is useful for targeted data recovery or verifying specific
> > image components without the overhead of a full traversal.
>
> Thanks for the patch!

Thank *you* for quick response!

>
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
> > ---
> >   fsck/main.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/fsck/main.c b/fsck/main.c
> > index ab697be..a7d9f46 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -39,6 +39,8 @@ struct erofsfsck_cfg {
> >       bool preserve_owner;
> >       bool preserve_perms;
> >       bool dump_xattrs;
> > +     erofs_nid_t nid;
> > +     const char *inode_path;
> >       bool nosbcrc;
> >   };
> >   static struct erofsfsck_cfg fsckcfg;
> > @@ -59,6 +61,8 @@ static struct option long_options[] =3D {
> >       {"offset", required_argument, 0, 12},
> >       {"xattrs", no_argument, 0, 13},
> >       {"no-xattrs", no_argument, 0, 14},
> > +     {"nid", required_argument, 0, 15},
> > +     {"path", required_argument, 0, 16},
> >       {"no-sbcrc", no_argument, 0, 512},
> >       {0, 0, 0, 0},
> >   };
> > @@ -110,6 +114,8 @@ static void usage(int argc, char **argv)
> >               " --extract[=3DX]          check if all files are well en=
coded, optionally\n"
> >               "                        extract to X\n"
> >               " --offset=3D#             skip # bytes at the beginning =
of IMAGE\n"
> > +             " --nid=3D#                check or extract from the targ=
et inode of nid #\n"
> > +             " --path=3DX               check or extract from the targ=
et inode of path X\n"
> >               " --no-sbcrc             bypass the superblock checksum v=
erification\n"
> >               " --[no-]xattrs          whether to dump extended attribu=
tes (default off)\n"
> >               "\n"
> > @@ -245,6 +251,12 @@ static int erofsfsck_parse_options_cfg(int argc, c=
har **argv)
> >               case 14:
> >                       fsckcfg.dump_xattrs =3D false;
> >                       break;
> > +             case 15:
> > +                     fsckcfg.nid =3D (erofs_nid_t)atoll(optarg);
> > +                     break;
> > +             case 16:
> > +                     fsckcfg.inode_path =3D optarg;
> > +                     break;
> >               case 512:
> >                       fsckcfg.nosbcrc =3D true;
> >                       break;
> > @@ -981,7 +993,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, =
erofs_nid_t nid)
> >
> >       if (S_ISDIR(inode.i_mode)) {
> >               struct erofs_dir_context ctx =3D {
> > -                     .flags =3D EROFS_READDIR_VALID_PNID,
> > +                     .flags =3D (pnid =3D=3D nid && nid !=3D g_sbi.roo=
t_nid) ?
>
> Does it relax the validatation check?
>
> and does (nid =3D=3D pnid && nid =3D=3D fsckcfg.nid) work?

It shouldn't relax the existing validation check.
`erofsfsck_check_inode` is called with `err =3D
erofsfsck_check_inode(fsckcfg.nid, fsckcfg.nid);`.

* If a given path is not the root, `nid`'s parent `..` will differ
from `pnid`, causing failure. This condition only relaxes the starting
directory.
* In the case of the root, `nid`'s parent `..` should indeed be
itself. So we can still validate.

If you have any better suggestions, I'll follow them.

>
> > +                             0 : EROFS_READDIR_VALID_PNID,
> >                       .pnid =3D pnid,
> >                       .dir =3D &inode,
> >                       .cb =3D erofsfsck_dirent_iter,
> > @@ -1033,6 +1046,8 @@ int main(int argc, char *argv[])
> >       fsckcfg.preserve_owner =3D fsckcfg.superuser;
> >       fsckcfg.preserve_perms =3D fsckcfg.superuser;
> >       fsckcfg.dump_xattrs =3D false;
> > +     fsckcfg.nid =3D 0;
> > +     fsckcfg.inode_path =3D NULL;
> >
> >       err =3D erofsfsck_parse_options_cfg(argc, argv);
> >       if (err) {
> > @@ -1068,22 +1083,37 @@ int main(int argc, char *argv[])
> >       if (fsckcfg.extract_path)
> >               erofsfsck_hardlink_init();
> >
> > -     if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
> > -             err =3D erofs_packedfile_init(&g_sbi, false);
> > +     if (fsckcfg.inode_path) {
> > +             struct erofs_inode inode =3D { .sbi =3D &g_sbi };
> > +
> > +             err =3D erofs_ilookup(fsckcfg.inode_path, &inode);
> >               if (err) {
> > -                     erofs_err("failed to initialize packedfile: %s",
> > -                               erofs_strerror(err));
> > +                     erofs_err("failed to lookup %s", fsckcfg.inode_pa=
th);
> >                       goto exit_hardlink;
> >               }
>
> It would be better to check if it's a directory.

My intention was that we support both directories and files. Or should
I create a separate flag like `--cat` in dump.erofs?

>
> Thanks,
> Gao Xiang
>
> > +             fsckcfg.nid =3D inode.nid;
> > +     } else if (!fsckcfg.nid) {
> > +             fsckcfg.nid =3D g_sbi.root_nid;
> > +     }
> >
> > -             err =3D erofsfsck_check_inode(g_sbi.packed_nid, g_sbi.pac=
ked_nid);
> > -             if (err) {
> > -                     erofs_err("failed to verify packed file");
> > -                     goto exit_packedinode;
> > +     if (!fsckcfg.inode_path && fsckcfg.nid =3D=3D g_sbi.root_nid) {
> > +             if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > =
0) {
> > +                     err =3D erofs_packedfile_init(&g_sbi, false);
> > +                     if (err) {
> > +                             erofs_err("failed to initialize packedfil=
e: %s",
> > +                                       erofs_strerror(err));
> > +                             goto exit_hardlink;
> > +                     }
> > +
> > +                     err =3D erofsfsck_check_inode(g_sbi.packed_nid, g=
_sbi.packed_nid);
> > +                     if (err) {
> > +                             erofs_err("failed to verify packed file")=
;
> > +                             goto exit_packedinode;
> > +                     }
> >               }
> >       }
> >
> > -     err =3D erofsfsck_check_inode(g_sbi.root_nid, g_sbi.root_nid);
> > +     err =3D erofsfsck_check_inode(fsckcfg.nid, fsckcfg.nid);
> >       if (fsckcfg.corrupted) {
> >               if (!fsckcfg.extract_path)
> >                       erofs_err("Found some filesystem corruption");
>

--=20
Inseob Kim | Software Engineer | inseob@google.com

