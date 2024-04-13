Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B68A39D3
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 02:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712969926;
	bh=Yjb0Sr1KEZR5EAjD8RSQ2yL2hvMhXaxBhQfzbu2ikx4=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JmJrvfkTRV9X2YGWA2psJEnCxfG3HABNPRXhftPfjvf0lctmAxrC/6snKEdXaV2v9
	 FwOK5pbk1gIniFesCoD8YxNa3O5lcZWF0lPhlv3Ga4fsqCMjKcJX/x9L//dXit/L0q
	 KhYr/Crk8ScFKuNNGtamhPRIE2R2YiAa/I/SJkDD2GzSiPIYwv9TvgFFJWkrcm/pc9
	 QWLw+ApBCBLTFkRQ/gn78djQqZZBYw4+HvfYu4ZE6xXO+na2lbq8OEG8jKAhwoxcmc
	 MoCuhIH4tylTYIuojb+NsqohOefJ60+d+LT7pHaMbA8cU46rsBO/s8MqvpZHSdRiK2
	 P64O7qb4v8ovQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VGZnL3f0Kz3dgN
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Apr 2024 10:58:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=FWh0n+6H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VGZnC60pkz3cGc
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Apr 2024 10:58:38 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so1128055f8f.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 12 Apr 2024 17:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712969912; x=1713574712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yjb0Sr1KEZR5EAjD8RSQ2yL2hvMhXaxBhQfzbu2ikx4=;
        b=aTuzoRFarVZ42Ug+nwBhULD0vcbuEeri5t1YLf/UiM1r8AToEF8OkpKP7YrFLKTwRx
         +gg8TcMngYycuzoAaBBPlvoE3+Iy8oY/cyI9qxGjyLYQmi/2uOEFvpL461NMX3kBS77Z
         eUDZOBaJK7Oc6w+SzA2aOU+EL1fyYcTiPG0KBL0abZ+6U3RuFR6TL1FCzKUcBO4QxrUQ
         MYjNUvdY55s9Mu3/3nzaWx7SmAmmDMVeV52GrksIxjz2IA0C74MdAcKk5IHHVPaMsgbo
         89Ot683zp7/7brmQ8WsebBrTBVwu+RpT6Q61rmLPdogiBmGDF0i98OXtfGy15pOTMOzi
         P4nQ==
X-Gm-Message-State: AOJu0YzdQQKW+h70VKkLMAXjc/wgGx2E1UMZuzm77o/nnJS0qt42/PNy
	gY3wwPDLBtCKSQYGD3wfdIz440ZJz77vEIiTR6w1ZjRK70Bf7sr/vF6jh8+Yn07ci5Z8AdFoxR1
	lMCwRWrgUQ7Wif5Y7LgWg3Y4kw2TYUDxvtF4zRruTrNL5/a9YnQ==
X-Google-Smtp-Source: AGHT+IFLdEvPfRv7jy90Y24vVSzfwF48K4093YYPF+oE2T1nisM86if8D1vAmu9BPr4GkEV17UKfIMbs+bUDBALR5zw=
X-Received: by 2002:a5d:6744:0:b0:343:a8cb:7990 with SMTP id
 l4-20020a5d6744000000b00343a8cb7990mr3001998wrw.29.1712969911618; Fri, 12 Apr
 2024 17:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240409221430.3897453-1-dhavale@google.com> <4a37b61c-ee55-4663-8b99-220c3931a524@linux.alibaba.com>
In-Reply-To: <4a37b61c-ee55-4663-8b99-220c3931a524@linux.alibaba.com>
Date: Fri, 12 Apr 2024 17:58:19 -0700
Message-ID: <CAB=BE-TRaOCbwaHonn5ZEw4m4BfcdjPO3yd-GLCjfcbBSPUZhw@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: lib: treat data blocks filled with 0s as
 a hole
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 12, 2024 at 5:07=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2024/4/10 06:14, Sandeep Dhavale wrote:
> > Add optimization to treat data blocks filled with 0s as a hole.
> > Even though diskspace savings are comparable to chunk based or dedupe,
> > having no block assigned saves us redundant disk IOs during read.
> >
> > To detect blocks filled with zeros during chunking, we insert block
> > filled with zeros (zerochunk) in the hashmap. If we detect a possible
> > dedupe, we map it to the hole so there is no physical block assigned.
> >
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> > ---
> > Changes since v1:
> >       - Instead of checking every block for 0s word by word,
> >         add a zerochunk in blobs during init. So we effectively
> >         detect the zero blocks by comparing the hash.
> >   include/erofs/blobchunk.h |  2 +-
> >   lib/blobchunk.c           | 41 ++++++++++++++++++++++++++++++++++++--=
-
> >   mkfs/main.c               |  2 +-
> >   3 files changed, 40 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
> > index a674640..ebe2efe 100644
> > --- a/include/erofs/blobchunk.h
> > +++ b/include/erofs/blobchunk.h
> > @@ -23,7 +23,7 @@ int erofs_write_zero_inode(struct erofs_inode *inode)=
;
> >   int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t dat=
a_offset);
> >   int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi);
> >   void erofs_blob_exit(void);
> > -int erofs_blob_init(const char *blobfile_path);
> > +int erofs_blob_init(const char *blobfile_path, erofs_off_t chunksize);
> >   int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int d=
evices);
> >
> >   #ifdef __cplusplus
> > diff --git a/lib/blobchunk.c b/lib/blobchunk.c
> > index 641e3d4..87c153f 100644
> > --- a/lib/blobchunk.c
> > +++ b/lib/blobchunk.c
> > @@ -323,13 +323,21 @@ int erofs_blob_write_chunked_file(struct erofs_in=
ode *inode, int fd,
> >                       ret =3D -EIO;
> >                       goto err;
> >               }
> > -
> >               chunk =3D erofs_blob_getchunk(sbi, chunkdata, len);
> >               if (IS_ERR(chunk)) {
> >                       ret =3D PTR_ERR(chunk);
> >                       goto err;
> >               }
>
>
> Sorry for late reply since I'm working on multi-threaded mkfs.
>
Hi Gao,
Thank you for the feedback!
> Can erofs_blob_getchunk directly return &erofs_holechunk? I mean,
Ok, I will re-work this part.
>
> static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *=
sbi,
>                                                 u8 *buf, erofs_off_t chun=
ksize)
> {
> ...
>         chunk =3D hashmap_get_from_hash(&blob_hashmap, hash, sha256);
>         if (chunk) {
>                 DBG_BUGON(chunksize !=3D chunk->chunksize);
>
>                 if (chunk->blkaddr =3D=3D erofs_holechunk.blkaddr)
>                         chunk =3D &erofs_holechunk;
>
>                 sbi->saved_by_deduplication +=3D chunksize;
>                 erofs_dbg("Found duplicated chunk at %u", chunk->blkaddr)=
;
>                 return chunk;
>         }
> ...
> }
>
> >
> > +             if (chunk->blkaddr =3D=3D erofs_holechunk.blkaddr) {
> > +                     *(void **)idx++ =3D &erofs_holechunk;
> > +                     erofs_update_minextblks(sbi, interval_start, pos,
> > +                                             &minextblks);
> > +                     interval_start =3D pos + len;
>
>
> I guess several zerochunks can also be merged?  is this line
> an expected behavior?
>
My understanding was for minextblks we need to consider only
contiguous physical, in other words, assigned blocks.
Let me think more about it.
> > +                     lastch =3D NULL;
> > +                     continue;
> > +             }
> > +
> >               if (lastch && (lastch->device_id !=3D chunk->device_id ||
> >                   erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize !=
=3D
> >                   erofs_pos(sbi, chunk->blkaddr))) {
>
> I guess we could form a helper like
> static bool erofs_blob_can_merge(struct erofs_sb_info *sbi,
>                             struct erofs_blobchunk *lastch,
>                             struct erofs_blobchunk *chunk)
> {
>         if (lastch =3D=3D &erofs_holechunk && chunk =3D=3D &erofs_holechu=
nk)
>                 return true;
>         if (lastch->device_id =3D=3D chunk->device_id &&
>             erofs_pos(sbi, lastch->blkaddr) + lastch->chunksize =3D=3D
>             erofs_pos(sbi, chunk->blkaddr))
>                 return true;
>         return false;
> }
>
>                 if (lastch && erofs_blob_can_merge(sbi, lastch, chunk)) {
>                         ...
>                 }
>
>
>
> > @@ -540,7 +548,34 @@ void erofs_blob_exit(void)
> >       }
> >   }
> >
> > -int erofs_blob_init(const char *blobfile_path)
> > +static int erofs_insert_zerochunk(erofs_off_t chunksize)
> > +{
> > +     u8 *zeros;
> > +     struct erofs_blobchunk *chunk;
> > +     u8 sha256[32];
> > +     unsigned int hash;
> > +
> > +     zeros =3D calloc(1, chunksize);
> > +     if (!zeros)
> > +             return -ENOMEM;
> > +
> > +     erofs_sha256(zeros, chunksize, sha256);
> > +     hash =3D memhash(sha256, sizeof(sha256));
>
>
> `zeros` needs to be freed here I guess:
>         free(zeros);
That's oversight on my part, thanks for the catch!

Thanks,
Sandeep.
>
> Thanks,
> Gao Xiang
>
> > +     chunk =3D malloc(sizeof(struct erofs_blobchunk));
> > +     if (!chunk)
> > +             return -ENOMEM;> +
> > +     chunk->chunksize =3D chunksize;
> > +     /* treat chunk filled with zeros as hole */
> > +     chunk->blkaddr =3D erofs_holechunk.blkaddr;
> > +     memcpy(chunk->sha256, sha256, sizeof(sha256));
> > +
> > +     hashmap_entry_init(&chunk->ent, hash);
> > +     hashmap_add(&blob_hashmap, chunk);
> > +     return 0;
> > +}
> > +
