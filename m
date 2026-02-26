Return-Path: <linux-erofs+bounces-2427-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VnXWH9bCn2nkdgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2427-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 04:49:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6291A0AE4
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Feb 2026 04:49:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLyBp0nsgz2yFb;
	Thu, 26 Feb 2026 14:49:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772077778;
	cv=pass; b=Oen93EdRgVA0B/TEv3K6KFBLb9G+xiFCUnsGH8qt1jsepMS+uKJ050s1tkXS3+xLLD7OMGVvvRbl0a8VH6kiN4KMgOA/urjyvQIbcMdUvYVjNxHT8qTCaVKkLNAYbGEjQCtj8wLoi1f0p+FxGjvwJ7v/no/wqdlnn9VSYZ2gLdiqhvOqSqeMTXcSunyNFszIk9Y1ZCodgSIk3mKgNQqzBlW3f2FGkETFMQ3fddCHMAzQZyedCRTD/X/81+CuonFxV5R42nwLLSluZ/oi7+7KoUmKrHFrTlsi6IgJ7G3QjIQSx8MAIpz4+dSheBu/+h0a5TPbzipk5lUTQMFlCWdQCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772077778; c=relaxed/relaxed;
	bh=JMCPhoSZh5UBBRxyvPNlpdqeRAk6e3nzPT2ce0OKmFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHuEXh6BHoDi22RYfvVaIcdwoLWbquH6/bbhAHsAvTUT6zggd/4+iHR2DDj6vi6tHturs8Iq9yYC+GRdX5VH0ua2xRHxxzoa90CS4op9lNcWnSszN0vHpQ3crTyVZK8q+5QIthU+akluXGLIFTxQt1j5Oz4RBZvrDsbBRn65sThLxTWy4IOtPFehiGfzf+gfuxlrBgRVSGqa+wv9N89mpC5ujpQgVOENjjL9tXvIq0IpTIFYjdMCznkJVs4eIxNFuWeN9E4GZbNdGSc8tFDqcLHSybpAL9Hu8kk/NpkFQlqzCgc8/+0NprPYWFX6J3ibxtxce+0uSXpSFusCSRDpew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=VLHXMXM2; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=inseob@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=VLHXMXM2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=inseob@google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLyBm1RRwz2xQs
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Feb 2026 14:49:35 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-65f93fff5c5so4009a12.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 19:49:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772077772; cv=none;
        d=google.com; s=arc-20240605;
        b=QVHWy0tjxBM8K28r53QzwXAI4mYGDgGrkgOCWitcuVB+1WCR7OzzUMCJzYsuQqkzLO
         xKM3Prn0PjzPXQyyWGv+YenxueIBA/upw6Cx5lOEt9ZqLaAmWwsCAp3zaCegWJFTwszf
         0UvZZ0FLJrAqZg9RAzTO6IKtE1xeCmnTNV1WD8X7t7ATezMmKdNIBUFdjB+R39a2B+IT
         rZictCwFKOOZ3Vxkef2pzj/FpVi5cEqcg1Sjp1BAE9WCFiFnaRRPYj+T+9X1aTrX2MFp
         xUTn2g4WPf1boGh75/4xX+xaklwDj8bNVVvJP4oLhgGVE5vcjOq9tvmktCnhtWCKU2NC
         se2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JMCPhoSZh5UBBRxyvPNlpdqeRAk6e3nzPT2ce0OKmFY=;
        fh=WJhIciIiNZdDmLC1ZQ8ngNos9wKcoX5v3UjHHDA3Xes=;
        b=lkng4EfoZcsGHtWzraZsJq1O0TfwHXYAQkTPij4V7yI0XfOT0HkKdedU0ASqHiLqyL
         qlJw+QieXyQkdIDsyK8Kacj1h+jLlQ2wZLENKiUjOoqYGpFgVP3UQrjll0PBl1KTWatl
         9PYLisxSicVEZZAoDz8mz5ucy3W7Molk5iIxN3j1CqZtWPbNCvUPi8Mi4RSkuzI0mGtu
         OjWOhQOrotZamZ0m2uoICvWnH3xaTh/h1whfj/uejE+kGOxyKq74WbBRvRSnkTnRXR29
         pbGRX5J/oa+I877Fu+NAVVGCFQSnJTURe6RBGnBNTh3yjM2MGK4GQXwKcxsk8HWLIa1O
         StKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772077772; x=1772682572; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMCPhoSZh5UBBRxyvPNlpdqeRAk6e3nzPT2ce0OKmFY=;
        b=VLHXMXM2MFjyYsCLTfw7bxTqEdBZ988ww91Q59UYkPYazXkvkepU7HbG3Ti5IAwlQl
         S5GPzAgAL9y7JHPE8zygSuK/jfPLj71EUGyZfW/8orpNi+JoGjbFUKPAxWyAEAXYFVsb
         I01hE9qYxN1Tegyjub6o7BNn7wJGFzE92EYEg1+LA7NjE9LF6uZcGiLFwhEsOsby0oXc
         sRA+luD+IIUeN/amtojPZsL779nItKdREQb2FeiVDZ3nxMqJGLr3ZcZwVXrHiAlZV51J
         Skb3vkun5PAegbNTpUuRCzmhHrRzkZHkA88jlo6LrUdIEehx7vCXZCdFIW37+7SpCZMw
         eSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772077772; x=1772682572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMCPhoSZh5UBBRxyvPNlpdqeRAk6e3nzPT2ce0OKmFY=;
        b=sJp1oQ4USkwL4jElYV7HY8pZQcMRARYhinbXzle2vCUU+J3osAj9uenbbWILL4b4jo
         EHP29vXScSo6t3I3n7RHf7nFerUtqTwzPegfSkApnhWEZ7lyzGaKwCt/pM+VOujp8LqV
         lwhdqgcNcf2J0bnycgM+N0KVhmSbxprk5wyTqmNSP5bnNJQaaEmEFbuntDkjmuAVOQ83
         XLAMMEcKEMzbgH1T0p42susduQB7Cax3myBYuvEgCFRct0nLbJKVPxJ+oECjDpCzerYR
         usecDE7nns6OHoSm+RqABXS1pTQt2Yhvv9iNbmjC9nkGVDVkyQuohMmBLMn4cnTWUYPE
         2cHw==
X-Gm-Message-State: AOJu0YzxtuX3/nnCJRxU84MOO4VpJ5cSLNOsfNYBz+QZZAFpMgV7fX/p
	fP354T2XlCP/D+ypZlbjvKulCGfx3xTFwXKLOTj95gqdptQwz1A9zbo/u2wNOCc4pQkEXHwOc/O
	7/amKaYDlTzxQ8iAma8NfPAh5hSud72QDtb8t0nsDkleMJ7YqnFSEtMR7
X-Gm-Gg: ATEYQzzSbAn9y7ig+/Ez3lzaOp22lnBzSVCwMVwe5hZsHPpZJtW0oa7+WgR4YEA1yib
	y2ktN5RmeFnQerlPfzIPenohYCi1L53cWMCB+sQx2/Kytqx8yWlGnrOLPO4wQ7WNwJjmF0qL81V
	G+ihQ/dh2xpHnmOyUb7LrM3nRboO/OGd4z6Pm+Yp0bme2h/wG8ROC6IQMEjh5f0RGq8jxL0j01O
	gmmjyd4hBTm0Kz1ZTQJeRlfaxIuwajRO3u5EE3HOaa19qCLClykhQztUnBagvkLKHmlpn9Ybetk
	H/m2d20voISNQZ/qynznS/AfkpQ6SfftHKcfZ8bnT0BUBio=
X-Received: by 2002:a05:6402:1253:b0:658:133d:8eb9 with SMTP id
 4fb4d7f45d1cf-65fab60e65amr20850a12.2.1772077771366; Wed, 25 Feb 2026
 19:49:31 -0800 (PST)
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
 <CA+QFDKmznnFDVM7OBVWNQdTzXUu3o1vq0ALZjq54Nb530tpL6w@mail.gmail.com> <f93ceb56-9ddc-47c8-a3d5-c4ccc91f3a28@linux.alibaba.com>
In-Reply-To: <f93ceb56-9ddc-47c8-a3d5-c4ccc91f3a28@linux.alibaba.com>
From: Inseob Kim <inseob@google.com>
Date: Thu, 26 Feb 2026 12:49:18 +0900
X-Gm-Features: AaiRm50wyGm0upu6YHazfiRiUS8nkFneGMhgHGATopziBx-IYDb6Ys2YN3_8wR8
Message-ID: <CA+QFDKkaw8EAfiptJL3VkO3qH_iM3Lzo+=JJ32tH9u9cKi=o3w@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2427-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: EA6291A0AE4
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:37=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
>
>
>
> On 2026/2/26 10:18, Inseob Kim wrote:
> > On Thu, Feb 26, 2026 at 10:50=E2=80=AFAM Gao Xiang <hsiangkao@linux.ali=
baba.com> wrote:
> >>
> >> Hi Inseob,
> >>
> >> On 2026/2/26 08:59, Inseob Kim wrote:
> >>> Add --nid and --path options to fsck.erofs to allow users to check
> >>> or extract specific sub-directories or files instead of the entire
> >>> filesystem.
> >>>
> >>> This is useful for targeted data recovery or verifying specific
> >>> image components without the overhead of a full traversal.
> >>
> >> Thanks for the patch!
> >
> > Thank *you* for quick response!
> >
> >>
> >>>
> >>> Signed-off-by: Inseob Kim <inseob@google.com>
> >>> ---
> >>>    fsck/main.c | 50 ++++++++++++++++++++++++++++++++++++++++---------=
-
> >>>    1 file changed, 40 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fsck/main.c b/fsck/main.c
> >>> index ab697be..a7d9f46 100644
> >>> --- a/fsck/main.c
> >>> +++ b/fsck/main.c
> >>> @@ -39,6 +39,8 @@ struct erofsfsck_cfg {
> >>>        bool preserve_owner;
> >>>        bool preserve_perms;
> >>>        bool dump_xattrs;
> >>> +     erofs_nid_t nid;
> >>> +     const char *inode_path;
> >>>        bool nosbcrc;
> >>>    };
> >>>    static struct erofsfsck_cfg fsckcfg;
> >>> @@ -59,6 +61,8 @@ static struct option long_options[] =3D {
> >>>        {"offset", required_argument, 0, 12},
> >>>        {"xattrs", no_argument, 0, 13},
> >>>        {"no-xattrs", no_argument, 0, 14},
> >>> +     {"nid", required_argument, 0, 15},
> >>> +     {"path", required_argument, 0, 16},
> >>>        {"no-sbcrc", no_argument, 0, 512},
> >>>        {0, 0, 0, 0},
> >>>    };
> >>> @@ -110,6 +114,8 @@ static void usage(int argc, char **argv)
> >>>                " --extract[=3DX]          check if all files are well=
 encoded, optionally\n"
> >>>                "                        extract to X\n"
> >>>                " --offset=3D#             skip # bytes at the beginni=
ng of IMAGE\n"
> >>> +             " --nid=3D#                check or extract from the ta=
rget inode of nid #\n"
> >>> +             " --path=3DX               check or extract from the ta=
rget inode of path X\n"
> >>>                " --no-sbcrc             bypass the superblock checksu=
m verification\n"
> >>>                " --[no-]xattrs          whether to dump extended attr=
ibutes (default off)\n"
> >>>                "\n"
> >>> @@ -245,6 +251,12 @@ static int erofsfsck_parse_options_cfg(int argc,=
 char **argv)
> >>>                case 14:
> >>>                        fsckcfg.dump_xattrs =3D false;
> >>>                        break;
> >>> +             case 15:
> >>> +                     fsckcfg.nid =3D (erofs_nid_t)atoll(optarg);
> >>> +                     break;
> >>> +             case 16:
> >>> +                     fsckcfg.inode_path =3D optarg;
> >>> +                     break;
> >>>                case 512:
> >>>                        fsckcfg.nosbcrc =3D true;
> >>>                        break;
> >>> @@ -981,7 +993,8 @@ static int erofsfsck_check_inode(erofs_nid_t pnid=
, erofs_nid_t nid)
> >>>
> >>>        if (S_ISDIR(inode.i_mode)) {
> >>>                struct erofs_dir_context ctx =3D {
> >>> -                     .flags =3D EROFS_READDIR_VALID_PNID,
> >>> +                     .flags =3D (pnid =3D=3D nid && nid !=3D g_sbi.r=
oot_nid) ?
> >>
> >> Does it relax the validatation check?
> >>
> >> and does (nid =3D=3D pnid && nid =3D=3D fsckcfg.nid) work?
> >
> > It shouldn't relax the existing validation check.
> > `erofsfsck_check_inode` is called with `err =3D
> > erofsfsck_check_inode(fsckcfg.nid, fsckcfg.nid);`.
> >
> > * If a given path is not the root, `nid`'s parent `..` will differ
> > from `pnid`, causing failure. This condition only relaxes the starting
> > directory.
>
> I just have a wild thought, if there is a directory which have
>
>   foo/
>   | - .. -> pointing to `foo` itself
>     - a/ -> pointing to `foo` directory too
>
> will (pnid =3D=3D nid && nid !=3D g_sbi.root_nid) relaxs
> the check for a/ ?
>
> I'm not sure but you could double check.

Thank you for pointing that out. I'll try retrieving the parent before
calling `erofsfsck_check_inode` and then pass it correctly.

>
> > * In the case of the root, `nid`'s parent `..` should indeed be
> > itself. So we can still validate.
> >
> > If you have any better suggestions, I'll follow them.
> >
> >>
> >>> +                             0 : EROFS_READDIR_VALID_PNID,
> >>>                        .pnid =3D pnid,
> >>>                        .dir =3D &inode,
> >>>                        .cb =3D erofsfsck_dirent_iter,
> >>> @@ -1033,6 +1046,8 @@ int main(int argc, char *argv[])
> >>>        fsckcfg.preserve_owner =3D fsckcfg.superuser;
> >>>        fsckcfg.preserve_perms =3D fsckcfg.superuser;
> >>>        fsckcfg.dump_xattrs =3D false;
> >>> +     fsckcfg.nid =3D 0;
> >>> +     fsckcfg.inode_path =3D NULL;
> >>>
> >>>        err =3D erofsfsck_parse_options_cfg(argc, argv);
> >>>        if (err) {
> >>> @@ -1068,22 +1083,37 @@ int main(int argc, char *argv[])
> >>>        if (fsckcfg.extract_path)
> >>>                erofsfsck_hardlink_init();
> >>>
> >>> -     if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0) {
> >>> -             err =3D erofs_packedfile_init(&g_sbi, false);
> >>> +     if (fsckcfg.inode_path) {
> >>> +             struct erofs_inode inode =3D { .sbi =3D &g_sbi };
> >>> +
> >>> +             err =3D erofs_ilookup(fsckcfg.inode_path, &inode);
> >>>                if (err) {
> >>> -                     erofs_err("failed to initialize packedfile: %s"=
,
> >>> -                               erofs_strerror(err));
> >>> +                     erofs_err("failed to lookup %s", fsckcfg.inode_=
path);
> >>>                        goto exit_hardlink;
> >>>                }
> >>
> >> It would be better to check if it's a directory.
> >
> > My intention was that we support both directories and files. Or should
> > I create a separate flag like `--cat` in dump.erofs?
>
> Ok, make sense.
>
> Thanks,
> Gao Xiang



--=20
Inseob Kim | Software Engineer | inseob@google.com

