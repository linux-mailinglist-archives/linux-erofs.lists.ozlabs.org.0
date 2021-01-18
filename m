Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B942F9FA4
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 13:30:51 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DKB2v2s6PzDr3F
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Jan 2021 23:30:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DKB1v0Y0BzDqbc
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Jan 2021 23:29:49 +1100 (AEDT)
Received: from [192.168.3.176] (unknown [116.56.134.80])
 by front (Coremail) with SMTP id AWSowABXXgYSfwVgmofKAQ--.59430S2;
 Mon, 18 Jan 2021 20:29:07 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 2/2] erofs-utils: optimize buffer allocation logic
Message-Id: <77494F58-C017-4496-BA5E-08B6334DE251@mail.scut.edu.cn>
Date: Mon, 18 Jan 2021 20:29:23 +0800
To: Gao Xiang <hsiangkao@aol.com>
X-Mailer: iPad Mail (18C66)
X-CM-TRANSID: AWSowABXXgYSfwVgmofKAQ--.59430S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr48KFy3ur4DZFWxuF1ftFb_yoW3tryfpF
 9IkF18GrWkXr1I9Fn2qrnxKryfXwn3JF1Ykw1fA3sYvrWDJrs2gFyDJF98ArWrKrZ7XrsF
 qF129a48CFWj9rDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5PpnJUUUUU==
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAFBlepTBDbYgABsY
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

=EF=BB=BFHi Xiang,

Thank you, your patch is indeed clearer. Could you explain why you don=E2=80=
=99t like my added erofs_dbg? I found them very useful when debugging.

I=E2=80=99ve updated the commit message, with some fixes (see inline) in PAT=
CH v5 (coming soon).

> =E5=9C=A8 2021=E5=B9=B41=E6=9C=8816=E6=97=A5=EF=BC=8C14:41=EF=BC=8CGao Xia=
ng <hsiangkao@aol.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFFrom: Hu Weiwen <sehuww@mail.scut.edu.cn>
>=20
> When using EROFS to pack our dataset which consists of millions of
> files, mkfs.erofs is very slow compared with mksquashfs.
>=20
> The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
> iterate over all previously allocated buffer blocks, making the
> complexity of the algrithm O(N^2) where N is the number of files.
>=20
> With this patch:
>=20
> * global `last_mapped_block` is mantained to avoid full scan in
> `erofs_mapbh` function.
>=20
> * global `non_full_buffer_blocks` mantains a list of buffer block for
> each type and each possible remaining bytes in the block. Then it is
> used to identify the most suitable blocks in future `erofs_balloc`,
> avoiding full scan.
>=20
> Some new data structure is allocated in this patch, more RAM usage is
> expected, but not much. When I test it with ImageNet dataset (1.33M
> files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
> spent on IO.
>=20
> Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>
> ---
>=20
> I've simplified the most-fit finding logic of v3... Since buffers.off
> has to be aligned to alignsize, so I think it's better to use
> buffers.off as the index of mapped_buckets compared to using remaining
> size as it looks more straight-forward.
>=20
> Also, I found the exist logic handling expended blocks might be
> potential ineffective as well... we have to skip used < used0 only
> after oob (extra blocks is allocated, so not expend such blocks but
> allocate a new bb...) It might be more effective to reuse such
> non-mapped buffer blocks...
>=20
> Thanks,
> Gao Xiang
>=20
> include/erofs/cache.h |  1 +
> lib/cache.c           | 91 +++++++++++++++++++++++++++++++++++++------
> 2 files changed, 81 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index f8dff67b9736..611ca5b8432b 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -39,6 +39,7 @@ struct erofs_buffer_head {
>=20
> struct erofs_buffer_block {
> struct list_head list;
> +    struct list_head mapped_list;
>=20
> erofs_blk_t blkaddr;
> int type;
> diff --git a/lib/cache.c b/lib/cache.c
> index 32a58311f563..a44e140bc77b 100644
> --- a/lib/cache.c
> +++ b/lib/cache.c
> @@ -18,6 +18,11 @@ static struct erofs_buffer_block blkh =3D {
> };
> static erofs_blk_t tail_blkaddr;
>=20
> +/* buckets for all mapped buffer blocks to boost up allocation */
> +static struct list_head mapped_buckets[2][EROFS_BLKSIZ];
> +/* last mapped buffer block to accelerate erofs_mapbh() */
> +static struct erofs_buffer_block *last_mapped_block =3D &blkh;
> +
> static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
> {
> return erofs_bh_flush_generic_end(bh);
> @@ -62,12 +67,17 @@ struct erofs_bhops erofs_buf_write_bhops =3D {
> /* return buffer_head of erofs super block (with size 0) */
> struct erofs_buffer_head *erofs_buffer_init(void)
> {
> +    int i, j;
> struct erofs_buffer_head *bh =3D erofs_balloc(META, 0, 0, 0);
>=20
> if (IS_ERR(bh))
>   return bh;
>=20
> bh->op =3D &erofs_skip_write_bhops;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(mapped_buckets); i++)
> +        for (j =3D 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
> +            init_list_head(&mapped_buckets[i][j]);
> return bh;
> }
>=20
> @@ -132,20 +142,55 @@ struct erofs_buffer_head *erofs_balloc(int type, ero=
fs_off_t size,
> struct erofs_buffer_block *cur, *bb;
> struct erofs_buffer_head *bh;
> unsigned int alignsize, used0, usedmax;
> +    unsigned int used_before, used;
>=20
> int ret =3D get_alignsize(type, &type);
>=20
> if (ret < 0)
>   return ERR_PTR(ret);
> +
> +    DBG_BUGON(type < 0 || type > META);
> alignsize =3D ret;
>=20
> used0 =3D (size + required_ext) % EROFS_BLKSIZ + inline_ext;
> usedmax =3D 0;
> bb =3D NULL;
>=20
> -    list_for_each_entry(cur, &blkh.list, list) {
> -        unsigned int used_before, used;
> +    if (!used0 || alignsize =3D=3D EROFS_BLKSIZ)
> +        goto alloc;
> +
> +    /* try to find a most-fit mapped buffer block first */
> +    for (used_before =3D EROFS_BLKSIZ; used_before > 1; ) {

I would argue that it is more efficient if we use a more specific initial va=
lue for used_before.

> +        struct list_head *bt =3D mapped_buckets[type] + --used_before;
> +
> +        if (list_empty(bt))
> +            continue;
> +        cur =3D list_first_entry(bt, struct erofs_buffer_block,
> +                       mapped_list);
> +
> +        /* last mapped block can be expended, don't handle it here */
> +        if (cur =3D=3D last_mapped_block)
> +            continue;
> +
> +        ret =3D __erofs_battach(cur, NULL, size, alignsize,
> +                      required_ext + inline_ext, true);
> +        if (ret < 0)

If used_before is chosen properly, this should never fail.

> +            continue;
> +
> +        /* should contain all data in the current block */
> +        used =3D ret + required_ext + inline_ext;
> +        DBG_BUGON(used > EROFS_BLKSIZ);
> +
> +        bb =3D cur;
> +        usedmax =3D used;
> +        break;
> +    }
>=20
> +    /* try to start from the last mapped one, which can be expended */
> +    cur =3D last_mapped_block;
> +    if (cur =3D=3D &blkh)
> +        cur =3D list_next_entry(cur, list);
> +    for (; cur !=3D &blkh; cur =3D list_next_entry(cur, list)) {
>   used_before =3D cur->buffers.off % EROFS_BLKSIZ;
>=20
>   /* skip if buffer block is just full */
> @@ -187,6 +232,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs=
_off_t size,
>   goto found;
> }
>=20
> +alloc:
> /* allocate a new buffer block */
> if (used0 > EROFS_BLKSIZ)
>   return ERR_PTR(-ENOSPC);
> @@ -200,6 +246,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs=
_off_t size,
> bb->buffers.off =3D 0;
> init_list_head(&bb->buffers.list);
> list_add_tail(&bb->list, &blkh.list);
> +    init_list_head(&bb->mapped_list);
>=20
> bh =3D malloc(sizeof(struct erofs_buffer_head));
> if (!bh) {
> @@ -214,6 +261,18 @@ found:
> return bh;
> }
>=20
> +static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
> +{
> +    struct list_head *bkt;
> +
> +    if (bb->blkaddr =3D=3D NULL_ADDR)
> +        return;
> +
> +    bkt =3D mapped_buckets[bb->type] + bb->buffers.off % EROFS_BLKSIZ;
> +    list_del(&bb->mapped_list);
> +    list_add_tail(&bb->mapped_list, bkt);
> +}
> +
> struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
>               int type, unsigned int size)
> {
> @@ -239,6 +298,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_b=
uffer_head *bh,
>   free(nbh);
>   return ERR_PTR(ret);
> }
> +    erofs_bupdate_mapped(bb);

This line should goes into =E2=80=9C__erofs_battach()=E2=80=9D? Since =E2=80=
=9Cerofs_balloc()=E2=80=9D only calls that function.

> return nbh;
>=20
> }
> @@ -247,8 +307,11 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_=
block *bb)
> {
> erofs_blk_t blkaddr;
>=20
> -    if (bb->blkaddr =3D=3D NULL_ADDR)
> +    if (bb->blkaddr =3D=3D NULL_ADDR) {
>   bb->blkaddr =3D tail_blkaddr;
> +        last_mapped_block =3D bb;
> +        erofs_bupdate_mapped(bb);
> +    }
>=20
> blkaddr =3D bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
> if (blkaddr > tail_blkaddr)
> @@ -259,15 +322,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer=
_block *bb)
>=20
> erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
> {
> -    struct erofs_buffer_block *t, *nt;
> +    struct erofs_buffer_block *t =3D last_mapped_block;
>=20
> -    if (!bb || bb->blkaddr =3D=3D NULL_ADDR) {
> -        list_for_each_entry_safe(t, nt, &blkh.list, list) {
> -            (void)__erofs_mapbh(t);
> -            if (t =3D=3D bb)
> -                break;
> -        }
> -    }
> +    do {
> +        t =3D list_next_entry(t, list);
> +        if (t =3D=3D &blkh)
> +            break;
> +
> +        DBG_BUGON(t->blkaddr !=3D NULL_ADDR);
> +        (void)__erofs_mapbh(t);
> +    } while (t !=3D bb);
> return tail_blkaddr;
> }
>=20
> @@ -309,6 +373,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
>=20
>   erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
>=20
> +        list_del(&p->mapped_list);
>   list_del(&p->list);
>   free(p);
> }
> @@ -332,6 +397,10 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool t=
ryrevoke)
> if (!list_empty(&bb->buffers.list))
>   return;
>=20
> +    if (bb =3D=3D last_mapped_block)
> +        last_mapped_block =3D list_prev_entry(bb, list);
> +
> +    list_del(&bb->mapped_list);
> list_del(&bb->list);
> free(bb);
>=20
> --=20
> 2.24.0

