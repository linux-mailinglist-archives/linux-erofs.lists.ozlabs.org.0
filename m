Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841ADA073B4
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 11:49:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTM494nFhz3bxZ
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jan 2025 21:49:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736419784;
	cv=none; b=c0Y19VEACDPPJELfk64YO+Z//BEoQJXRLTBaWzoc6WKZzZjiQWnUPiNegE/yU78t9b76CzNTSIaZMB3AEySHrdZBiS5RjeWEG3ESFR9yk9HuYAOvjCzFCjq1lEI5nc9TWx/PV3p7aJM4UtQ5YzizJWknqCGF4uyCBZgIfKC9ngD8DgI8dfv60ehriJtueZfLYIZmj7rGFrnP94/dJ+dejRho0YpAMKaQIzsisOVTUDyu/oQaDY2E0afbMrfJjZDBOtZZajMdvCQd9CZ9xJiozgi9mUieAtOtwQNkM0DiIkWCBSjtFLsIsT6Bq3MtVh6TwfiuOptHOH53Xa7XG1VX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736419784; c=relaxed/relaxed;
	bh=4tz7djsH743OxiWIx+Q3LH8V4JrDclk2piaPdZmTmIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao/AZIT0ihVyjOrK6NewOwPbcWIe12o8IpnJqAg+CvDp+Y3VgjMzEBGa7oe6kTPJFQD78vlWd1/xCt1kqwtiS9TAsMz23Kb5E/rmwQuODgufyzlbV2WT7rn0qmheADl5EtD0ZOPar3QM9ANfJixFqoM55XPsno6VRFI5TzEDF04AGq2UcHqt41I0looOULu9OjvuniJgIWPB7JN7dvSufV1/NS57orft+jiG0HG8bvbv6uhVRzZvUFYEB8vPHvJA4Y38pdQcJVL1WYP73Mn5SMLiFWv6jRiyy4Ny9nC83oSPGYab4mYPj8ecnkAoz0jjpVXxpiC5ahl/pUMO3smuYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkttVpEU; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkttVpEU; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhernand@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkttVpEU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkttVpEU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jhernand@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTM466C57z3bWH
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jan 2025 21:49:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736419779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tz7djsH743OxiWIx+Q3LH8V4JrDclk2piaPdZmTmIU=;
	b=QkttVpEUNrwBdIXL3tRkLhb1qRo4BZOLKWWLLLwmylr9o182kz+Ffw6OZ6GcaWbc2oBHcs
	7CLHoHxEkE37hllhM4Clkzt7E4Rwb39rvR5mpVHNG2vDdFUbrWfNYM+BnmWv7d9BkFaW1k
	tIei0jYufz+EYvSVEj8WSvNn69di/pw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736419779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4tz7djsH743OxiWIx+Q3LH8V4JrDclk2piaPdZmTmIU=;
	b=QkttVpEUNrwBdIXL3tRkLhb1qRo4BZOLKWWLLLwmylr9o182kz+Ffw6OZ6GcaWbc2oBHcs
	7CLHoHxEkE37hllhM4Clkzt7E4Rwb39rvR5mpVHNG2vDdFUbrWfNYM+BnmWv7d9BkFaW1k
	tIei0jYufz+EYvSVEj8WSvNn69di/pw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-JSHUu6gDMoeTsu50oXtqdg-1; Thu, 09 Jan 2025 05:49:37 -0500
X-MC-Unique: JSHUu6gDMoeTsu50oXtqdg-1
X-Mimecast-MFC-AGG-ID: JSHUu6gDMoeTsu50oXtqdg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38a35a65575so488676f8f.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jan 2025 02:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419776; x=1737024576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tz7djsH743OxiWIx+Q3LH8V4JrDclk2piaPdZmTmIU=;
        b=QU7Sv1u2UaVS86ZR4mDngOtx8EAXOR0u+CdvpvD1hEGRmf8X6LX/7DPersh53GNHXt
         9wbECx9qsa4DwOcSp3Y7XJdr0ftVrGeRqbjegH71DotH2fODfyqkwyc/NkPWoiCH5GSo
         B9t5jt5IPxlWJ0KxkEkLBxhFCmdbYctqlB/YSNodsOXrFomrm5fSj/L330GsoNJMyqfZ
         4VvIYztykQUD3AoA4DdgnJA0KDlp4jJMDrxS1eGAj33w0HMKdwqXfz0Ic1NkrLNg5eGm
         1gbsEpzHUNSEz6nPO+mTsZ5XwxQ/p8enrdEgJLNQpZzfPcf42kaD1l9HBvOB/vGEItqy
         6Tzw==
X-Gm-Message-State: AOJu0YzH3uX258XB16MOBv9+qxC7zdlx68rodKW5i5z3WQ2yEr4vO+wk
	qViCpZkF4Nt/HAZnqupxB6DH71jvB532iCyS4bxBzSzJsfOmJEFuTgyKhf+D2AdOdmryW+NHAo5
	92qoRL1Yi+dC8w41xkhoxckl85wmeovv8MN+gRBOnhgbiBSO272/wcxKM+kaQBfFffmCxfyBdmN
	NS+BFtVxjgJ68oXialNXMG8Cc1kzU7TerEbpQCWu/Lk7i1YCQ=
X-Gm-Gg: ASbGncu97RceyVMBZjf8ZW6sdlAB73W3iUhrtvqmetPBpab5fXs5mUq5CRs62txh96/
	23ait0bamCcwWORbVYOBRQ3eehQ4XIpCVoT5IvQ==
X-Received: by 2002:a5d:6484:0:b0:385:fd07:85f4 with SMTP id ffacd0b85a97d-38a87312c8dmr5717862f8f.31.1736419775781;
        Thu, 09 Jan 2025 02:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG324XaCLLpJS4jRcfGUW1v76q1FynQFwoUlbMpXXIeB2gAudgAhXLaEGZini/SsvznHCMsmCQLTGQOTd9yQGs=
X-Received: by 2002:a5d:6484:0:b0:385:fd07:85f4 with SMTP id
 ffacd0b85a97d-38a87312c8dmr5717807f8f.31.1736419775275; Thu, 09 Jan 2025
 02:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20250109095526.71911-1-jhernand@redhat.com> <e7af73ff-f951-4144-8d7d-d0fecfbd75da@linux.alibaba.com>
In-Reply-To: <e7af73ff-f951-4144-8d7d-d0fecfbd75da@linux.alibaba.com>
From: =?UTF-8?Q?Juan_Hern=C3=A1ndez?= <jhernand@redhat.com>
Date: Thu, 9 Jan 2025 11:49:08 +0100
X-Gm-Features: AbW1kvZLrjiFKHerKgoOTTRWEL4IIG0Y4v0eF__WG75WM0VWK2MWQOCiclfjO2U
Message-ID: <CABxE0VzSbSsdoefYCg+cDP=TP9-tMARHr9D9mvrYtrkCY-aucw@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: dump: Add --cat flag to show file contents
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 08f2MgmC97Nmafl0pbd3ZMyqDCa_FMQdidk6NM7dmmY_1736419776
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thanks for your feedback Gao! I will address your concerns.

On Thu, Jan 9, 2025 at 11:43=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Juan,
>
> On 2025/1/9 17:55, Juan Hernandez wrote:
> > This patch adds a new '--cat' flag to the 'dump.erofs' command. When
> > used it will write to the standard output the content of the file
> > indicated by the '--path' or '--nid' options. For example, if there is =
a
> > '/mydir/myfile.txt' file containg the text 'mytext':
> >
> >      $ dump.erofs --cat --path=3D/mydir/myfile.txt myimage.erofs
> >      mytext
> >
> > Signed-off-by: Juan Hernandez <jhernand@redhat.com>
>
> Thanks for the patch!
> It looks good to me, just minor nits..
>
> > ---
> >   dump/main.c      | 72 +++++++++++++++++++++++++++++++++++++++++++++++=
+
> >   man/dump.erofs.1 | 13 +++++++--
> >   2 files changed, 83 insertions(+), 2 deletions(-)
> >
> > diff --git a/dump/main.c b/dump/main.c
> > index 372162e..ed8d44d 100644
> > --- a/dump/main.c
> > +++ b/dump/main.c
> > @@ -26,6 +26,7 @@ struct erofsdump_cfg {
> >       bool show_superblock;
> >       bool show_statistics;
> >       bool show_subdirectories;
> > +     bool show_file_content;
> >       erofs_nid_t nid;
> >       const char *inode_path;
> >   };
> > @@ -80,6 +81,7 @@ static struct option long_options[] =3D {
> >       {"path", required_argument, NULL, 4},
> >       {"ls", no_argument, NULL, 5},
> >       {"offset", required_argument, NULL, 6},
> > +     {"cat", no_argument, NULL, 7},
> >       {0, 0, 0, 0},
> >   };
> >
> > @@ -123,6 +125,7 @@ static void usage(int argc, char **argv)
> >               " -s              show information about superblock\n"
> >               " --device=3DX      specify an extra device to be used to=
gether\n"
> >               " --ls            show directory contents (INODE required=
)\n"
> > +             " --cat           show file contents (INODE required)\n"
> >               " --nid=3D#         show the target inode info of nid #\n=
"
> >               " --offset=3D#      skip # bytes at the beginning of IMAG=
E\n"
> >               " --path=3DX        show the target inode info of path X\=
n",
> > @@ -186,6 +189,9 @@ static int erofsdump_parse_options_cfg(int argc, ch=
ar **argv)
> >                               return -EINVAL;
> >                       }
> >                       break;
> > +             case 7:
> > +                     dumpcfg.show_file_content =3D true;
> > +                     break;
> >               default:
> >                       return -EINVAL;
> >               }
> > @@ -672,6 +678,63 @@ static void erofsdump_show_superblock(void)
> >                       uuid_str);
> >   }
> >
> > +static void erofsdump_show_file_content(void)
> > +{
> > +     int err;
> > +     struct erofs_inode inode =3D { .sbi =3D &g_sbi, .nid =3D dumpcfg.=
nid };
> > +     size_t buffer_size;
> > +     char *buffer_ptr;
> > +     erofs_off_t pending_size;
> > +     erofs_off_t read_offset;
> > +     erofs_off_t read_size;
> > +
> > +     if (dumpcfg.inode_path) {
> > +             err =3D erofs_ilookup(dumpcfg.inode_path, &inode);
> > +             if (err) {
> > +                     erofs_err("read inode failed @ %s", dumpcfg.inode=
_path);
> > +                     return;
> > +             }
> > +     } else {
> > +             err =3D erofs_read_inode_from_disk(&inode);
> > +             if (err) {
> > +                     erofs_err("read inode failed @ nid %llu", inode.n=
id | 0ULL);
> > +                     return;
> > +             }
> > +     }
> > +
> > +     if (!S_ISREG(inode.i_mode)) {
>
> I think we could dump raw directory content too.
>
>
> > +             erofs_err("not a regular file @ nid %llu", inode.nid | 0U=
LL);
> > +             return;
> > +     }
> > +
> > +     buffer_size =3D erofs_blksiz(inode.sbi);
> > +     buffer_ptr =3D malloc(buffer_size);
> > +     if (!buffer_ptr) {
> > +             erofs_err("buffer allocation failed @ nid %llu", inode.ni=
d | 0ULL);
> > +             return;
> > +     }
> > +
> > +     pending_size =3D inode.i_size;
> > +     read_offset =3D 0;
> > +     while (pending_size > 0) {
> > +             read_size =3D pending_size > buffer_size? buffer_size: pe=
nding_size;
> > +             err =3D erofs_pread(&inode, buffer_ptr, read_size, read_o=
ffset);
> > +             if (err) {
> > +                     erofs_err("read file failed @ nid %llu", inode.ni=
d | 0ULL);
> > +                     goto out;
> > +             }
> > +             pending_size -=3D read_size;
> > +             read_offset +=3D read_size;
> > +             fwrite(buffer_ptr, read_size, 1, stdout);
> > +     }
> > +     fflush(stdout);
> > +
> > +out:
> > +     free(buffer_ptr);
> > +}
> > +
> > +
> > +
>
> Reduntant new lines..
>
> Thanks,
> Gao Xiang
>

