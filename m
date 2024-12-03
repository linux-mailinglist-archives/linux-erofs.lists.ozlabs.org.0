Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3559E1135
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 03:21:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1733192473;
	bh=qdo3cIwFH1r2/SxCiYO1wq8XBFrh796RcfnNdoc/hrY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Qa5gpeV+LWaBC1IyQNj+jBnSjYZx2bm/5zb0aXErr3FYhHBLrzOJMIhh8lKGFDGe3
	 CNzAMp9AvGKKPM9Qzaf52UXpjBGhQa/8+5Nt4r2UWZj9OJxb5Q05eMKwaVJukDqH/I
	 AdI1G1vGroOTdgT6UHVu99A/VbTglyN8So+vjzabz3tMOEjR2Zrw25wT7wLVNw2Jtv
	 KvP6EjZdZrVVuPVHUHlHbOjfj19rrc5Ig91HwzJfcy/wopghBQmQj4H7lfHq08bvZW
	 dFUveAuTUI+h3sraaOSMS0qDBo6YoKn7rBm372KPKVklcyuNVpjM0F4jmBijiWP/sH
	 UH9iOIjthH6NQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2PXT2xWDz301T
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Dec 2024 13:21:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733192467;
	cv=none; b=Unt+Ub3RC59JEU/AOrIxwomfZ67yO8DeSyxhoeshLWc+2SJBrvh6H8BwzyO+98lie4mHBBnlUEX7mtp6j4cJ1CISGTCMffwzdHoIne+NOYeSFWhm8gb77vpzzqxdSVLg92SPNMuY97nrmiiiB8uxnsq4YlBlDFm5u686bJVZeVy14wJe/IlabeYM++m3OvVd2WfojvDflikSeXqTzqQg/rRfSFH5twimCZTD8/sKaBkI4xFSFUZJJ1849cqa8b5KUmOM/yrx+Iw9r421S7Uy0kxtb1+BYOuyvPBOUPCv9iVkaDryWYqw9aRt2osMSZG3o9oA2C0VSkJ+dfV5/26m2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733192467; c=relaxed/relaxed;
	bh=qdo3cIwFH1r2/SxCiYO1wq8XBFrh796RcfnNdoc/hrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iw0rTQyg0wLJA+Kwf0EzjP6ziibUeNfKYBywXxz/nkuMStgdmL0hy1hJMromwWHrVn92VQCanvNHniasiuZLlI//wlj5+rZ9U3bHAl8EgodeTSOvmzyad2oq6Dpu/iFRENomR4/dlQeLANi0VZGnBc6zo8wYvkBxTzPuGwExUQLvjOcTFwwlcrKbAexfLll3Ap0rfuB1zsysLJ3f4KndVD3Q0X19jpyjN4/bbykKXg2BNxAUiuDpHm0gTQi8D2n92ipLAqBoeFZpvPDrbUpdqaRmNwxNtMvMSDlADYVJ4+wBWk3SjDBuAR7z0nJ3URcKUsL+VnkOSPOLRDh8QdaZxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=O3TBLe4N; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=jooyung@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=O3TBLe4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=jooyung@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2PXD2yngz2yRP
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Dec 2024 13:20:59 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so4389061b3a.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Dec 2024 18:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733192456; x=1733797256; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdo3cIwFH1r2/SxCiYO1wq8XBFrh796RcfnNdoc/hrY=;
        b=O3TBLe4NU+PdlgLb5UlViobf3XbJ/YUwGwufPxm2V0VpyLqyDk9IkJWWTn609MsP0+
         meEURibovN/1JDt5dPiBuiS3IFA8/qvqywX9R8HZRyUETp7tQSPitk7RnfK2VWzThG+U
         socMPUvgsu3bhz1ScWxBhvPaiyNFoOFsVQ9eu+C9ksPU/vEQq/Yud88cPuci7p7eM9Ey
         gHoebzqjtLuFSwJuuXBfgE1Bk7HrxBh0fKE8bF0KXsqaE8dZyJ2uG7/6UIFhkfXRYJQ9
         gjIkV4gBbx59Nk4JxHudEIY45TitcHKJJj2L9gfnfvervvcWMI5l9N7UIOqK3NKjL4GE
         teEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733192456; x=1733797256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdo3cIwFH1r2/SxCiYO1wq8XBFrh796RcfnNdoc/hrY=;
        b=f+biNAJ2mVoY+IDPRAag5zRDBeuF3xV4tJzW1u9HvNWZUpjTGJxxgN6EnRC7lu7iL6
         cHliW96DCVSvVK8LcVzhmcQw+/ffp5P7mFdFKF3iqIBtHiuwtcBXyuyVGT8OSxQv588b
         /fRzua5ih4Vo18mNpAWcIZiOVsxsC9eOU3r7AgFYlmsaWkMPvu+CQ1vFd2hBN016OXDT
         4rRI7Fpyrqsqi77iWkaFAcJWzWsxNCHBhE9zrQytb56zpD/PpfMnJNAQJ0SWf/4wkSBD
         zdRQSzYFnsbqBLOK6QBCoDsbwUyHAX7tJV93uMpMh3ST5Ux/Ael2YwThHM5XuY+Ib3kJ
         6zhw==
X-Gm-Message-State: AOJu0YygyPFGBqIsXPm5u2yiJ+GbJd9krISnG9gR5vhJRMoCWxtYuQdH
	DoPfzzVmFtw9KLCRTLP0XpSgCaFi0TzW7Myr26TCdyv14Zp0IkRXzQ8bJf04a5i8pamo3rCc4VO
	lzFUP15te8JBW/DDvDu+tbkANglyZd83aLLZ0
X-Gm-Gg: ASbGncs6d4XaxcSo58n5AUFia/n7CD7kmCtv5XbDTcxkR3zyxbigczyrGczbk3Jic6S
	FNLN67kwxkVzSlr8UUHndN88jLmsr4Ky1aR9fDcsr6vDE8cVT7psC5DU0niY=
X-Google-Smtp-Source: AGHT+IFjFhHXmnpJ2OGgNAIt4STWRog2f6ia493dK6odzxvbCHaTZODyoI1gXavbwMWjA3SpZ42AE6TYpJp/RpRrrD4=
X-Received: by 2002:a17:90b:33cd:b0:2ee:a04b:92ce with SMTP id
 98e67ed59e1d1-2ef01270000mr1168120a91.32.1733192455941; Mon, 02 Dec 2024
 18:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20241203002720.3634151-1-jooyung@google.com> <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
In-Reply-To: <a5b7aaf8-4b94-44dd-9bff-8e12080a8063@linux.alibaba.com>
Date: Tue, 3 Dec 2024 11:20:44 +0900
Message-ID: <CAO-8PLbD1hbRW24Xu+kJ6Ak9JZ+508sYgMa1oDB1PQ77YUptXg@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: use scandir for stable output
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.0
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
From: Jooyung Han via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jooyung Han <jooyung@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao,

I found that in the loop erofs_iget_from_srcpath() is called in
different order due to readdir and erofs_iget_from_srcpath() calls
erofs_new_inode() which fills i_ino[0] for newly created inode. I
think this i_ino[0] having different values caused the difference in
the output.


On Tue, Dec 3, 2024 at 10:38=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Jooyung,
>
> On 2024/12/3 08:27, Jooyung Han wrote:
> > The iteration order of opendir/readdir depends on filesystem
> > implementation. Hence, even with the same contents, the filesystem of
> > the input directory affects the output.
> >
> > In this change, opendir/readdir is replaced with scandir for stable
> > order of iteration. This produces the same output regardless of the
> > filesystem of the input directory.
> >
> > Test: mkfs.erofs ... inputdir(ext3)
> > Test: mkfs.erofs ... inputdir(tmpfs)
> >    # should generate the same output
> > Signed-off-by: Jooyung Han <jooyung@google.com>
>
> Thanks for the patch.  I haven't tested the current behavior (1.8.2),
> but EROFS will sort all dirents in a directory in
> erofs_prepare_dir_file(). And then dump all subdirs in
> erofs_mkfs_dump_tree().
>
> It seems both dirents and inodes are sorted in the alphabetical
> order, could you give more hints about this?
>
> Thanks,
> Gao Xiang
>
> > ---
> >
> > v1: https://lore.kernel.org/linux-erofs/20241202232620.3604736-1-jooyun=
g@google.com/
> > change since v1:
> >   - modify commit msg (no change-id/bug/typo)
> >   - rename the label to err_cleanup
> >
> >   lib/inode.c | 39 ++++++++++++++-------------------------
> >   1 file changed, 14 insertions(+), 25 deletions(-)
> >
> > diff --git a/lib/inode.c b/lib/inode.c
> > index f553bec..097deef 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -1422,37 +1422,25 @@ static void erofs_mkfs_flushjobs(struct erofs_s=
b_info *sbi)
> >   static int erofs_mkfs_handle_directory(struct erofs_inode *dir)
> >   {
> >       struct erofs_sb_info *sbi =3D dir->sbi;
> > -     DIR *_dir;
> > -     struct dirent *dp;
> > +     struct dirent *dp, **dent;
> > +     int i, num_entries;
> >       struct erofs_dentry *d;
> >       unsigned int nr_subdirs, i_nlink;
> >       int ret;
> >
> > -     _dir =3D opendir(dir->i_srcpath);
> > -     if (!_dir) {
> > -             erofs_err("failed to opendir at %s: %s",
> > +     num_entries =3D scandir(dir->i_srcpath, &dent, NULL, alphasort);
> > +     if (num_entries =3D=3D -1) {
> > +             erofs_err("failed to scandir at %s: %s",
> >                         dir->i_srcpath, erofs_strerror(-errno));
> >               return -errno;
> >       }
> >
> >       nr_subdirs =3D 0;
> >       i_nlink =3D 0;
> > -     while (1) {
> > +     for (i =3D 0; i < num_entries; free(dent[i]), i++) {
> >               char buf[PATH_MAX];
> >               struct erofs_inode *inode;
> > -
> > -             /*
> > -              * set errno to 0 before calling readdir() in order to
> > -              * distinguish end of stream and from an error.
> > -              */
> > -             errno =3D 0;
> > -             dp =3D readdir(_dir);
> > -             if (!dp) {
> > -                     if (!errno)
> > -                             break;
> > -                     ret =3D -errno;
> > -                     goto err_closedir;
> > -             }
> > +             dp =3D dent[i];
> >
> >               if (is_dot_dotdot(dp->d_name)) {
> >                       ++i_nlink;
> > @@ -1466,17 +1454,17 @@ static int erofs_mkfs_handle_directory(struct e=
rofs_inode *dir)
> >               d =3D erofs_d_alloc(dir, dp->d_name);
> >               if (IS_ERR(d)) {
> >                       ret =3D PTR_ERR(d);
> > -                     goto err_closedir;
> > +                     goto err_cleanup;
> >               }
> >
> >               ret =3D snprintf(buf, PATH_MAX, "%s/%s", dir->i_srcpath, =
d->name);
> >               if (ret < 0 || ret >=3D PATH_MAX)
> > -                     goto err_closedir;
> > +                     goto err_cleanup;
> >
> >               inode =3D erofs_iget_from_srcpath(sbi, buf);
> >               if (IS_ERR(inode)) {
> >                       ret =3D PTR_ERR(inode);
> > -                     goto err_closedir;
> > +                     goto err_cleanup;
> >               }
> >               d->inode =3D inode;
> >               d->type =3D erofs_mode_to_ftype(inode->i_mode);
> > @@ -1484,7 +1472,7 @@ static int erofs_mkfs_handle_directory(struct ero=
fs_inode *dir)
> >               erofs_dbg("file %s added (type %u)", buf, d->type);
> >               nr_subdirs++;
> >       }
> > -     closedir(_dir);
> > +     free(dent);
> >
> >       ret =3D erofs_init_empty_dir(dir);
> >       if (ret)
> > @@ -1506,8 +1494,9 @@ static int erofs_mkfs_handle_directory(struct ero=
fs_inode *dir)
> >
> >       return erofs_mkfs_go(sbi, EROFS_MKFS_JOB_DIR, &dir, sizeof(dir));
> >
> > -err_closedir:
> > -     closedir(_dir);
> > +err_cleanup:
> > +     for (; i < num_entries; free(dent[i]), i++);
> > +     free(dent);
> >       return ret;
> >   }
> >
>
